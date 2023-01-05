//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit
import LSHContributionView

class HabitCell: UITableViewCell {

    @IBOutlet weak var contributionView: LSHContributionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    
    
    var data: Habit? {
        didSet {
            configureUIwithData()
        }
    }
    
    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        self.backgroundColor = .brown
        
        let dataSquare = [
                    [0, 1, 2, 3, 4],
                    [1, 2, 3, 4, 3],
                    [2, 3, 4, 3, 2],
                    [3, 4, 3, 2, 1],
                    [4, 3, 2, 1, 0]
                ]
           
        contributionView.data = dataSquare
        contributionView.colorScheme = "Halloween"
        contributionView.addEntry(with: CGPoint(x: 2, y: 2), level: 1)
        contributionView.gridSpacing = 0
        contributionView.gridMargin = 10

//        view.addSubview(contributionView)
        
        
        nameLabel.text = data?.name
        goalTitleLabel.text = data?.goalTitle
        percentLabel.text = data?.percentStr

    }
    


    
}
