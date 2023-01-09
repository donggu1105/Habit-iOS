//
//  DetailViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class DetailViewController: UIViewController {

    let coreDataManager = CoreDataManager.shared
    
    var habit: Habit?

//    weak var myParent: CallParent?

    @IBOutlet weak var acheiveButton: UIButton!
    



    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    func setUp() {

        self.view.backgroundColor = .black
        // 버튼
        acheiveButton.clipsToBounds = true
        acheiveButton.layer.cornerRadius = 8
        acheiveButton.setTitle("잔디 심기 🌱", for: .normal)
        acheiveButton.backgroundColor = UIColor(hexString: "14171e")
        
    }
 
    @IBAction func acheiveButtonTapped(_ sender: UIButton) {
        
        guard let habit = habit else {return}
        habit.acheiveCount = habit.acheiveCount + 1
        
        coreDataManager.updateData(newData: habit, completion: {
            print("업데이트 완료")
            // 다시 전화면으로 돌아가기
            self.navigationController?.popViewController(animated: true)

        })

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
