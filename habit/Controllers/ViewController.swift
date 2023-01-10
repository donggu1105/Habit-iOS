


import UIKit
import StoreKit
import JJFloatingActionButton

//protocol CallParent {
//    func collectionReload()
//}
class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 코어데이터
    let coreDataManager = CoreDataManager.shared
    

    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    func collectionReload() {
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // 네비게이션 셋업
        setupNaviBar()
        // 콜렉션뷰 셋업
        setUpCollectionView()
        // 롱프레스 버튼 셋업
//        setupLongGestureRecognizerOnCollection()
        // 플로팅 버튼 셋업
        setUpFloatingButton()
        
        
    }
    
    func setUpFloatingButton() {
        let actionButton = JJFloatingActionButton()

        actionButton.addItem(title: "잔디 등록하기", image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus")?.withRenderingMode(.alwaysTemplate)) { item in
            self.performSegue(withIdentifier: "register", sender: nil)
        }
        
//        actionButton.addItem(title: "잔디 등록 팁", image: UIImage(systemName: "list.clipboard.fill")?.withRenderingMode(.alwaysTemplate)) { item in
//            self.performSegue(withIdentifier: "tip", sender: nil)
//        }
        
        actionButton.addItem(title: "별점 남기기", image: UIImage(systemName: "paperplane.fill")?.withRenderingMode(.alwaysTemplate)) { item in
            SKStoreReviewController.requestReviewInCurrentScene()
        }

         actionButton.display(inViewController: self)
    }
    
//    func setupLongGestureRecognizerOnCollection() {
//        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
//        longPressedGesture.minimumPressDuration = 0.5
//        longPressedGesture.delegate = self
//        longPressedGesture.delaysTouchesBegan = true
//        collectionView?.addGestureRecognizer(longPressedGesture)
//
//    }
//
    
    
    func setUpCollectionView() {
        collectionView.backgroundColor = .black
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // extension 설정
        collectionView.dataSource = self
        collectionView.delegate = self
        // 컴포지셔널 레이아웃 설정
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
   
    
    func setupNaviBar() {

        self.title = "잔디 목록"
//         네비게이션바 타이틀 크게
        navigationController?.navigationBar.prefersLargeTitles = true
        // 네비게이션바 타이틀 중앙
//        navigationItem.largeTitleDisplayMode = .never

//      네비게이션바 우측에 Plus 버튼 만들기
//        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
//        plusButton.tintColor = .black
//        self.navigationItem.rightBarButtonItem = plusButton
        
    }
//    @objc func plusButtonTapped() {
//        performSegue(withIdentifier: "register", sender: nil)
//    }
    
    // (세그웨이를 실행할때) 실제 데이터 전달 (ToDoData전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let detailVC = segue.destination as! DetailViewController
            guard let indexPath = sender as? IndexPath else { return }
            detailVC.habit = coreDataManager.getHabitList()[indexPath.row]
        } else if segue.identifier == "register" {
            let registerVC = segue.destination as! RegisterViewController
            guard let indexPath = sender as? IndexPath else { return }
            registerVC.habit = coreDataManager.getHabitList()[indexPath.row]
        }
    }
}

extension ViewController {
    
    // 콤포지셔널 레이아웃 설정
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        // 콤포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout {
            // 만들게되면 튜플 (키: 값, 키:값) 의 묶음으로 들어옴 반화하는것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupHeight = NSCollectionLayoutDimension.fractionalHeight(0.9/3)
            
            // 그룹사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            
            // 그룹사이즈로 그룹 만들기
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
            // 만든 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            // 오른쪽 스크롤 가능
//            section.orthogonalScrollingBehavior = .continuous
//            section.orthogonalScrollingBehavior = .groupPaging
            
            // 섹션에 대한 간격
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            
            return section
        }
        
        return layout
    }
}

extension ViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        configureContextMenu(indexPath: indexPath)

    }
    


    
    func configureContextMenu(indexPath: IndexPath) -> UIContextMenuConfiguration {
           let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
               
               let edit = UIAction(title: "수정하기", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                   print("edit button clicked")
                   self.performSegue(withIdentifier: "register", sender: indexPath)
               }
               let delete = UIAction(title: "삭제하기", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
                   
                   // alert
                   let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
                   let confirm = UIAlertAction(title: "확인", style: .default) { (_) in
                          let habit = self.coreDataManager.getHabitList()[indexPath.row]
                          self.coreDataManager.deleteData(data: habit, completion: {
                              self.collectionView.reloadData()
                          })
                   }
                       let cancel = UIAlertAction(title: "취소", style: .cancel)
                       
                       alert.addAction(confirm)
                       alert.addAction(cancel)
                       
                       self.present(alert, animated: true, completion: nil)
                   }
               return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,delete])
           }
           return context
       }
    
}

extension ViewController: UICollectionViewDataSource {
    
    // 각 섹션에 들어가는 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataManager.getHabitList().count
    }
    
    // 각 콜렉션뷰셀에대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: HabitCell.self)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HabitCell
        // 셀에 모델(ToDoData) 전달
        let habitData = coreDataManager.getHabitList()
        cell.data = habitData[indexPath.row]
        
        return cell
    }
    
}

extension ViewController: UIGestureRecognizerDelegate {
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: collectionView)

        if let indexPath = collectionView?.indexPathForItem(at: p) {
            print("Long press at item: \(indexPath.row)")
        }
    }
    
}


