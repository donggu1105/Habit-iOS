//
//  HabitCell.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class HabitCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var goalTitle: UILabel!
    
    @IBOutlet weak var percent: UILabel!
    
    var habitData: Habit? {
        didSet {
            configureUIwithData()
        }
    }
    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        name.text = habitData?.name
        goalTitle.text = habitData?.goalTitle
        percent.text = habitData?.percentStr
        
        
        
//        toDoTextLabel.text = toDoData?.memoText
//        dateTextLabel.text = toDoData?.dateString
//        guard let colorNum = toDoData?.color else { return }
//        let color = MyColor(rawValue: colorNum) ?? .red
//        updateButton.backgroundColor = color.buttonColor
//        backgoundView.backgroundColor = color.backgoundColor
    }
    


    
}