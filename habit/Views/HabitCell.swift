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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets.init(top: 30, left: 0, bottom: 20, right: 0)
    }
    
    var data: Habit? {
        didSet {
            configureUIwithData()
        }
    }
    
    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        self.backgroundColor = .brown

        
        
        
        contributionView.data = LSHContributionView.makeDefaultSquareData()
        contributionView.colorScheme = "Default"
        
//        contributionView.addEntry(with: CGPoint(x: 1, y: 1), level: 5)
//        contributionView.addEntry(with: CGPoint(x: 1, y: 1), level: 5)
//        contributionView.addEntry(with: CGPoint(x: 2, y: 2), level: 1)
//        contributionView.addEntry(with: CGPoint(x: 2, y: 2), level: 1)
        contributionView.gridSpacing = 3
        contributionView.gridMargin = 10
        
    
           


//        view.addSubview(contributionView)
        
        
        nameLabel.text = data?.name
        goalTitleLabel.text = data?.goalTitle
//        percentLabel.text = data?.percentStr

    }
    


    
}
