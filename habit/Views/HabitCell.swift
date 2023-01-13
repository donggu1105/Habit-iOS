//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit
import PContributionsView



final class HabitCell: UICollectionViewCell {

    @IBOutlet weak var contributionView: PContributionsView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalTitleLabel: UILabel!
    

    // 지우기
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        
        // 셀 모양 셋업
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor(hexString: "14171e")
//        self.contentView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.borderWidth = 1
        
        // 컨트리뷰션 뷰 셋업
        contributionView.clipsToBounds = true
        contributionView.backgroundColor = UIColor(hexString: "14171e")
        contributionView.layer.cornerRadius = 10
        contributionView.cellCornerRadius(2)
        contributionView.spacing = 3


        
    }

    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData(habit: Habit) {
        print(#function)
        // 잔디 이름
        nameLabel.text = habit.name
        // 목표
        goalTitleLabel.text = habit.goalTitle

        let colorNum = habit.color
        contentView.backgroundColor = MyColor(rawValue: colorNum)!.backgoundColor
        contributionView.backgroundColor = MyColor(rawValue: colorNum)!.backgoundColor
        
        // 잔디 색칠하기
        print("acheiveCnt: \(habit.acheiveCount)")
        var dataSquare = ContributionHelper.getDataSqureByAchieveCount(acheiveCount: Int(habit.acheiveCount))
        contributionView.contrilbutionsData = dataSquare
        print("dataSquare: \(dataSquare)")
        
        self.layoutIfNeeded()
        
        }
    
        

}
