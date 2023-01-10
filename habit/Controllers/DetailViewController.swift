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
    
    @IBOutlet weak var cheerView: UIView!
    @IBOutlet weak var cheerLabel: UILabel!
    
    @IBOutlet weak var graphBackgroundView: UIView!
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var acheiveButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureWithUI()
    }
    
    
    func setUp() {
        self.view.backgroundColor = .black
        // cheer
        cheerView.backgroundColor = UIColor(hexString: "14171e")
        cheerView.clipsToBounds = true
        cheerView.layer.cornerRadius = 8
        // graph
        graphBackgroundView.backgroundColor = UIColor(hexString: "14171e")
        graphBackgroundView.clipsToBounds = true
        graphBackgroundView.layer.cornerRadius = 8
        // circularProgressView
        circularProgressView.backgroundColor = UIColor(hexString: "14171e")
//        circularProgressView.setprogress(0.4, UIColor.blue, "13", "")
        circularProgressView.animate(0.9, duration: 2)
        // 버튼
        acheiveButton.clipsToBounds = true
        acheiveButton.layer.cornerRadius = 8
        acheiveButton.setTitle("잔디 심기 🌱", for: .normal)
        acheiveButton.backgroundColor = UIColor(hexString: "14171e")
        
    }
 
    
    func configureWithUI() {
        guard let habit = self.habit else {return}
        
        
//        intPercent = Int(habit.percent)
        if let percent = habit.percent {
            cheerLabel.text = CheerUp.ment(percent: Int(percent))
            let percentStr = String(Int(percent)) + "%"
            
            circularProgressView.setprogress(0.0, UIColor(red:0.14, green:0.60, blue:0.23, alpha:1.0), percentStr, "D-\(habit.goalCount - habit.acheiveCount)")
            circularProgressView.animate(Double(percent) / 100, duration: 1)
            
        }


        
    }
    @IBAction func acheiveButtonTapped(_ sender: UIButton) {
        
        guard let habit = self.habit else {return}
        habit.acheiveCount += 1
        
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
