//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit



final class AcheiveListHabitCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
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
        self.contentView.backgroundColor = UIColor(hexString: "f6bd60")
//        self.contentView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        self.contentView.layer.cornerRadius = 8
//        self.contentView.layer.borderWidth = 1
        
        // 컨트리뷰션 뷰 셋업
//        contributionView.clipsToBounds = true
//        contributionView.backgroundColor = UIColor(hexString: "14171e")
//        contributionView.layer.cornerRadius = 10
//        contributionView.cellCornerRadius(2)
//        contributionView.spacing = 3

//        contributionView.userCustomColor(ColorMap("#F4F4F4", "#72FFFF", "#00D7FF", "#0096FF", "#5800FF"))

        
    }

    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        // 잔디 이름
        nameLabel.text = data?.name
        // 목표
        goalTitleLabel.text = data?.goalTitle

        guard let colorNum = data?.color else {return}
        if let color = MyColor(rawValue: colorNum) {
            contentView.backgroundColor = color.backgoundColor
//            contributionView.backgroundColor = color.backgoundColor
        }
        
        if let percent = data?.percent {
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
