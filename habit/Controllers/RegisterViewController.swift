//
//  DetailViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var goalTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    let coreDataManager = CoreDataManager.shared
    
    // ToDo 색깔 구분을 위해 임시적으로 숫자저장하는 변수
    // (나중에 어떤 색상이 선택되어 있는지 쉽게 파악하기 위해)
    var temporaryNum: Int64? = 1
    
//    var habitData: Habit? {
//        didSet {
//            temporaryNum = habitData?.color
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }


    
    func setup() {
        
        // 잔디 이름
        nameTextField.delegate = self
        nameTextField.placeholder = "잔디 이름"
        // 목표
        goalTextField.delegate = self
        goalTextField.placeholder = "목표"
        // 버튼
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 8
        
        
//        mainTextView.delegate = self
        
//        backgroundView.clipsToBounds = true
//        backgroundView.layer.cornerRadius = 10
        
//        saveButton.clipsToBounds = true
//        saveButton.layer.cornerRadius = 8
//        clearButtonColors()
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        coreDataManager.saveData(name: nameTextField.text,
                                 goalTitle: goalTextField.text,
                                 goalCount: 30,
                                 color: 1,
                                 achieveCount: 0) {
            print("저장완료")
            // 다시 전화면으로 돌아가기
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
            
            guard let mainVC = mainStoryboard
                .instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
            
            self.present(mainVC, animated: true)
            
            }
        
        
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
    }
}
