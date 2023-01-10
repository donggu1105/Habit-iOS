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
    @IBOutlet weak var createdDateLabel: UILabel!
    
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
        print(#function)
        // 잔디 이름
        nameLabel.text = data?.name
        // 목표
        goalTitleLabel.text = data?.goalTitle
        // 날짜
        if let createdDate = data?.createdDateStr {
            createdDateLabel.text = createdDate + "~"

        }
        // 잔디 컨트리뷰션
        contributionView.data = LSHContributionView.makeDefaultSquareData()
        // 잔디 색정하기
        contributionView.colorScheme = "Default"
        guard let colorNum = data?.color else {return}
        if let color = MyColor(rawValue: colorNum) {
            contentView.backgroundColor = color.backgoundColor
            contributionView.backgroundColor = color.backgoundColor
        }
        // 잔디 색칠하기
        if let acheiveCnt: Int64 = data?.acheiveCount {
            print("acheiveCnt: \(acheiveCnt)")
            colorWithAcheiveCount(acheiveCount: Int(acheiveCnt))
        }

    }
  
    
    func colorWithAcheiveCount(acheiveCount: Int) {
        
        
        var iterCnt = 0
        let x = acheiveCount % Goal.grassX // 나머지
        let y = acheiveCount / Goal.grassX // 몫
        

        repeat {
//            print("acheiveCount: \(acheiveCount)")
//            print("x: \(x) , y: \(y), iterCnt: \(iterCnt)")
            if (iterCnt < y) {
                for color in 0..<Goal.grassX {
                    contributionView.addEntry(with: CGPoint(x: color, y: iterCnt), level: 3)
                }
            } else {
//                print("줄바뀜")
                for color in 0..<x {
                    contributionView.addEntry(with: CGPoint(x: color, y: iterCnt), level: 3)
                }
            }
            iterCnt += 1
        } while (iterCnt <= y)
    }
}
