//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class HabitCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var progressBarView: CircularProgressView!
    
    
    var data: Habit? {
        didSet {
            configureUIwithData()
        }
    }
    
    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        self.backgroundColor = .brown
        nameLabel.text = data?.name
        goalTitleLabel.text = data?.goalTitle
        percentLabel.text = data?.percentStr
        
        if let percent = data?.percent {
            progressBarView.setProgress(to: Float(percent))
        }
        
    }
    


    
}
