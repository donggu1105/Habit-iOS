//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit
import LSHContributionView

class HabitCell: UICollectionViewCell {

    
    @IBOutlet weak var contributionView: LSHContributionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var goalTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 셀 모양 셋업
        self.contentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.contentView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.borderWidth = 1
        
        // 컨트리뷰션 뷰 셋업
        contributionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contributionView.layer.cornerRadius = 8
        contributionView.layer.borderWidth = 1
        contributionView.gridSpacing = 3
        contributionView.gridMargin = 10
    }
    
    var data: Habit? {
        didSet {
            configureUIwithData()
        }
    }
    
    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        contributionView.data = LSHContributionView.makeDefaultSquareData()
        contributionView.colorScheme = "Default"
//        contributionView.addEntry(with: CGPoint(x: 1, y: 1), level: 5)

        
        
        nameLabel.text = data?.name
        goalTitleLabel.text = data?.goalTitle

    }
    


    
}
