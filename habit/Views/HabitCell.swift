//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit
import LSHContributionView

//protocol CellActionDelegate {
//    func removeCellAtIndex(_ index: Int)
//}

class HabitCell: UICollectionViewCell {

    
    @IBOutlet weak var contributionView: LSHContributionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalTitleLabel: UILabel!
    
//    var shakeEnabled: Bool!
    
//    static var delegate: CellActionDelegate!
    
    
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
//        contributionView.layer.borderWidth = 1
        contributionView.gridSpacing = 3
        contributionView.gridMargin = 10
        
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

extension HabitCell {
    
//    
//       func shakeIcons() {
//           let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
//           shakeAnimation.duration = 0.05
//           shakeAnimation.repeatCount = 2
//           shakeAnimation.autoreverses = true
//           let startAngle: Float = (-2) * 3.14159/180
//           let stopAngle = -startAngle
//           shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
//           shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
//           shakeAnimation.autoreverses = true
//           shakeAnimation.duration = 0.2
//           shakeAnimation.repeatCount = 10000
//           shakeAnimation.timeOffset = 290 * drand48()
//           
//           let layer: CALayer = self.layer
//           layer.add(shakeAnimation, forKey:"shaking")
//           shakeEnabled = true
//       }
//       
//       func stopShakingIcons() {
//           let layer: CALayer = self.layer
//           layer.removeAnimation(forKey: "shaking")
//           self.deleteButton.isHidden = true
//           shakeEnabled = false
//       }
//       

    
}
