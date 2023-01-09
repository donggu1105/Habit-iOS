//
//  DetailViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let coreDataManager = CoreDataManager.shared


    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var goalTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    // ToDo 색깔 구분을 위해 임시적으로 숫자저장하는 변수
    // (나중에 어떤 색상이 선택되어 있는지 쉽게 파악하기 위해)
    var temporaryNum: Int64? = 1
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }

    func setup() {
        self.title = "새로운 잔디"
        // 콜렉션뷰 설정
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.backgroundColor = UIColor(hexString: "14171e")
        colorCollectionView.clipsToBounds = true
        colorCollectionView.layer.cornerRadius = 2
        colorCollectionView.isScrollEnabled = false
        colorCollectionView.collectionViewLayout = createCompositionalLayout()

        // 잔디 이름
        nameTextField.delegate = self
        nameTextField.placeholder = "잔디 이름"
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.backgroundColor = UIColor(hexString: "14171e")
        // 목표
        goalTextField.delegate = self
        goalTextField.placeholder = "목표"
        goalTextField.clearButtonMode = .whileEditing
        goalTextField.backgroundColor = UIColor(hexString: "14171e")
        // 버튼
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 8
        registerButton.setTitle("잔디 만들기", for: .normal)
        registerButton.backgroundColor = UIColor(hexString: "14171e")
        

    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        coreDataManager.saveData(name: nameTextField.text,
                                 goalTitle: goalTextField.text,
                                 goalCount: 30,
                                 color: 1,
                                 achieveCount: 0) {
            print("저장완료")
            // 다시 전화면으로 돌아가기
            self.navigationController?.popViewController(animated: true)
            }
        
        
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}


extension RegisterViewController: UICollectionViewDelegate {
    
}

extension RegisterViewController: UICollectionViewDataSource {

    // 각 섹션에 들어가는 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let values: [Int64] = MyColor.allCases.map { $0.rawValue }

        return values.count
    }
    
    // 각 콜렉션뷰 쎌에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCell.self), for: indexPath) as! ColorCell
        
        
        let values: [Int64] = MyColor.allCases.map { $0.rawValue }
        
        cell.color = MyColor(rawValue: values[indexPath.row])
        
        return cell
    }
}

extension RegisterViewController {
    
    
    // 콤포지셔널 레이아웃 설정
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        // 콤포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            // 만들게 되면 튜플 (키: 값, 키: 값) 의 묶음으로 들어옴 반환 하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute 는 고정값, estimated 는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
            
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 10, trailing: 20)
            
            // 변경할 부분
//            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/3)
            
            // 그룹사이즈
            let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // 그룹사이즈로 그룹 만들기
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitems: [item, item, item])
            
            // 변경할 부분
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitem: item, count: 7)
            
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            return section
        }
        return layout
    }
    
}
