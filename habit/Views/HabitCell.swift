//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit
import PContributionsView



final class HabitCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var acheiveCountLabel: UILabel!
    // 지우기
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        
        // 셀 모양 셋업
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor(hexString: "f6bd60")
        self.contentView.layer.cornerRadius = 8
        
        
    }

    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData(habit: Habit) {
        // 잔디 이름
        nameLabel.text = habit.name
        // 목표
        acheiveCountLabel.text = "\(habit.acheiveCount)회"
        
        let colorNum = habit.color
        contentView.backgroundColor = MyColor(rawValue: colorNum)!.backgoundColor
        
        if let percent = habit.percent {
            switch percent {
            case 0: imageView.image = UIImage(named: "level0")
            case 1...10: imageView.image = UIImage(named: "level1")
            case 11...20: imageView.image = UIImage(named: "level2")
            case 21...30: imageView.image = UIImage(named: "level3")
            case 31...50: imageView.image = UIImage(named: "level4")
            case 51...80: imageView.image = UIImage(named: "level5")
            case 80...100: imageView.image = UIImage(named: "level6")
            default: imageView.image = UIImage(named: "level0")
            }
        }
    }
}
