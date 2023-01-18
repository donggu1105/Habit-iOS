

import UIKit

class AcheiveDetailController: UIViewController {
    
    var habit: Habit?
    
    let coreDataManager = CoreDataManager.shared

    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "fefae0")
        // 콜렉션뷰 셋업
        setUpCollectionView()
        
    }
    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
    

    
    func configureWithUI() {
//        guard let habit = self.habit else { return }
    }
}

extension AcheiveDetailController: UICollectionViewDataSource {
    
    // 각 섹션에 들어가는 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataManager.getAcheiveList(habit: self.habit!).count
    }
    
    // 각 콜렉션뷰셀에대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: AcheiveCell.self)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AcheiveCell
        // 셀에 모델(ToDoData) 전달
        let acheiveData = coreDataManager.getAcheiveList(habit: self.habit!)
        cell.data = acheiveData[indexPath.row]
        
        return cell
    }
    
}

extension AcheiveDetailController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
    
}


extension AcheiveDetailController {
    
    // 콤포지셔널 레이아웃 설정
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        // 콤포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout {
            // 만들게되면 튜플 (키: 값, 키:값) 의 묶음으로 들어옴 반화하는것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.05))
            
            
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
//            let groupHeight = NSCollectionLayoutDimension.fractionalHeight(0.9/3)
            
            // 그룹사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.8))
            
            // 그룹사이즈로 그룹 만들기
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
            
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

