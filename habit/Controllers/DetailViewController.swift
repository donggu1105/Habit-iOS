//
//  DetailViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class DetailViewController: UIViewController {

    let coreDataManager = CoreDataManager.shared

    @IBOutlet weak var acheiveButton: UIButton!
    
    var habitData: Habit?



    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        
        //      네비게이션바 우측에 Plus 버튼 만들기
                let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
                plusButton.tintColor = .black
                navigationItem.rightBarButtonItem = plusButton
        setUp()
    }
    
    @objc func plusButtonTapped() {
        
    }
    
    func setUp() {
        // 버튼
        acheiveButton.clipsToBounds = true
        acheiveButton.layer.cornerRadius = 8
        acheiveButton.setTitle("잔디 심기", for: .normal)
        
    }
 
    @IBAction func acheiveButtonTapped(_ sender: UIButton) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
