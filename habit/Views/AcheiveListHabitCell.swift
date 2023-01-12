//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit
import PContributionsView



final class AcheiveListHabitCell: UICollectionViewCell {

    @IBOutlet weak var contributionView: PContributionsView!
    
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var data: Habit? {
        didSet {
            configureUIwithData()
        }
    }
    
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

//        contributionView.userCustomColor(ColorMap("#F4F4F4", "#72FFFF", "#00D7FF", "#0096FF", "#5800FF"))

        
    }

    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        print(#function)
        // 잔디 이름
        nameLabel.text = data?.name
        // 목표
        goalTitleLabel.text = data?.goalTitle

        guard let colorNum = data?.color else {return}
        if let color = MyColor(rawValue: colorNum) {
            contentView.backgroundColor = color.backgoundColor
            contributionView.backgroundColor = color.backgoundColor
        }
        // 잔디 색칠하기
        if let acheiveCount: Int64 = data?.acheiveCount {
            print("acheiveCnt: \(acheiveCount)")
            let dataSquare = ContributionHelper.getDataSqureByAchieveCount(acheiveCount: Int(acheiveCount))
            //            print(dataSquare)
            contributionView.contrilbutionsData = dataSquare
        }

    }
  

}
