//
//  DetailViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let coreDataManager = CoreDataManager.shared

    @IBOutlet weak var grassImage: UIImageView!
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var goalTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var grassLabel: UILabel!
    
    // ToDo 색깔 구분을 위해 임시적으로 숫자저장하는 변수
    // (나중에 어떤 색상이 선택되어 있는지 쉽게 파악하기 위해)
    var temporaryNum: Int64? = 999
 
    
    var habit: Habit? {
        didSet {
            temporaryNum = habit?.color
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        colorCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "fefae0")
        setup()
        configureUI()
    }


    func setup() {
        self.title = "새로운 잔디"
        // 콜렉션뷰 설정
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.backgroundColor = .white
        colorCollectionView.clipsToBounds = true
        colorCollectionView.layer.cornerRadius = 8
        colorCollectionView.isScrollEnabled = false
        colorCollectionView.collectionViewLayout = createCompositionalLayout()
        
        // 이미지
        grassImage.image = UIImage(named: "grass")?.withRenderingMode(.alwaysTemplate)

        // 잔디 이름
        nameTextField.delegate = self
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.backgroundColor = .white
        // 목표
        goalTextField.delegate = self
        goalTextField.clearButtonMode = .whileEditing
        goalTextField.backgroundColor = .white
        // 버튼
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 8
        registerButton.backgroundColor = UIColor(hexString: "f6bd60")
        registerButton.setTitleColor(.black, for: .normal)

        // 그래스 라벨
        grassLabel.text = "잔디 밭 색"
        grassLabel.textAlignment = .center
        

    }
    
    func configureUI() {
        
        // 기존데이터가 있을때
        if let habit = self.habit {
            self.title = "잔디 수정하기"
            nameTextField.becomeFirstResponder()
            nameTextField.text = habit.name
            goalTextField.text = habit.goalTitle
            registerButton.setTitle("잔디 수정하기", for: .normal)
            grassImage.tintColor = MyColor(rawValue: habit.color)?.backgoundColor
            grassLabel.textColor = MyColor(rawValue: habit.color)?.backgoundColor
            
        // 기존데이터가 없을때
        } else {
            self.title = "새로운 잔디"
            registerButton.setTitle("잔디 만들기", for: .normal)
            nameTextField.placeholder = "잔디 이름"
            goalTextField.placeholder = "목표"
            grassImage.tintColor = MyColor.defaultColor.backgoundColor
            grassLabel.textColor = MyColor.defaultColor.backgoundColor
        }
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        guard nameTextField.isValid(with: "잔디이름") else {
            let alert = UIAlertController(title: "잔디 이름을 입력해주세요.", message: nil, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        // 기존 데이터 있을때
        if let habit = self.habit {
            // 텍스트뷰에 저장되어 있는 메세지
            habit.name = nameTextField.text
            habit.goalTitle = goalTextField.text
            habit.color = temporaryNum ?? 999
            coreDataManager.updateData(newData: habit, completion: {
                print("업데이트 완료")
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            coreDataManager.saveData(name: nameTextField.text,
                                     goalTitle: goalTextField.text,
                                     goalCount: Int64(ContributionHelper.goalCount),
                                     color: temporaryNum ?? 999,
                                     achieveCount: 0) {
                print("저장완료")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    
}


extension RegisterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ColorCell
        
        grassImage.tintColor = cell.color?.backgoundColor
        grassLabel.textColor = cell.color?.backgoundColor
        temporaryNum = cell.color?.rawValue

    }
    
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
