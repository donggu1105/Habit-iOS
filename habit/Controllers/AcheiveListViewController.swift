


import UIKit
import StoreKit

class AcheiveListViewController: UIViewController {

    // 코어데이터
    let coreDataManager = CoreDataManager.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "fefae0")
        
        // 네비게이션 셋업
        setupNaviBar()
        // 콜렉션뷰 셋업
        setUpCollectionView()
        // 롱프레스 버튼 셋업
//        setupLongGestureRecognizerOnCollection()
        
        
    }
    
    
    func setUpCollectionView() {
        collectionView.backgroundColor = UIColor(hexString: "fefae0")
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // extension 설정
        collectionView.dataSource = self
        collectionView.delegate = self
        // 컴포지셔널 레이아웃 설정
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
   
    
    func setupNaviBar() {

        self.title = "완료한 잔디 목록"
//         네비게이션바 타이틀 크게
        navigationController?.navigationBar.prefersLargeTitles = true
        // 네비게이션바 타이틀 중앙
//        navigationItem.largeTitleDisplayMode = .never

//      네비게이션바 우측에 Plus 버튼 만들기
        
    }
}

extension AcheiveListViewController {
    
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

extension AcheiveListViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        // detail
        let vc1StoryboardID = String(describing: DetailViewController.self)
        let vc1 = storyboard.instantiateViewController(identifier: vc1StoryboardID) as! DetailViewController
        vc1.title = ""
        vc1.habit = coreDataManager.getAcheivedHabitList()[indexPath.row]

        // acheive detail
        let vc2StoryboardID = String(describing: AcheiveDetailController.self)
        let vc2 = storyboard.instantiateViewController(identifier: vc2StoryboardID) as! AcheiveDetailController
        vc2.habit = coreDataManager.getAcheivedHabitList()[indexPath.row]


        let tabVC = UITabBarController()
        tabVC.setViewControllers([vc1,vc2], animated: false)
//        tabVC.modalPresentationStyle = .fullScreen
        tabVC.tabBar.backgroundColor = UIColor(hexString: "fefae0")
        
        // 탭바 이미지 설정 (이미지는 애플이 제공하는 것으로 사용)
        guard let items = tabVC.tabBar.items else { return }
        
        items[0].image = UIImage(systemName: "leaf")
        items[1].image = UIImage(systemName: "waveform.and.magnifyingglass")
//        items[2].image = UIImage(systemName: "paperplane")
//        items[3].image = UIImage(systemName: "doc")
//        items[4].image = UIImage(systemName: "note")
        
        
        self.navigationController?.pushViewController(tabVC, animated: true)
            
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
                          let habit = self.coreDataManager.getAcheivedHabitList()[indexPath.row]
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

extension AcheiveListViewController: UICollectionViewDataSource {
    
    // 각 섹션에 들어가는 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataManager.getAcheivedHabitList().count
    }
    
    // 각 콜렉션뷰셀에대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: AcheiveListHabitCell.self)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AcheiveListHabitCell
        // 셀에 모델(ToDoData) 전달
        let habitData = coreDataManager.getAcheivedHabitList()
        cell.data = habitData[indexPath.row]
        
        return cell
    }
    
}



