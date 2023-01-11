//
//  DetailViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit
import SwiftEntryKit

class DetailViewController: UIViewController {

    
    let coreDataManager = CoreDataManager.shared
    
    var habit: Habit?
    
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var cheerView: UIView!
    @IBOutlet weak var cheerLabel: UILabel!
    
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var acheiveCountLabel: UILabel!
    @IBOutlet weak var graphBackgroundView: UIView!
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var acheiveButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureWithUI()
    }
    
    
    func setUp() {
        self.view.backgroundColor = .black
        // goalTitle
        // cheer
        cheerView.backgroundColor = UIColor(hexString: "14171e")
        cheerView.clipsToBounds = true
        cheerView.layer.cornerRadius = 8
        // graph
        graphBackgroundView.backgroundColor = UIColor(hexString: "14171e")
        graphBackgroundView.clipsToBounds = true
        graphBackgroundView.layer.cornerRadius = 8
        // circularProgressView
        circularProgressView.backgroundColor = UIColor(hexString: "14171e")
//        circularProgressView.setprogress(0.4, UIColor.blue, "13", "")
        circularProgressView.animate(0.9, duration: 2)
        // 버튼
        acheiveButton.clipsToBounds = true
        acheiveButton.layer.cornerRadius = 8
        acheiveButton.setTitle("잔디 심기 🌱", for: .normal)
        acheiveButton.backgroundColor = UIColor(hexString: "14171e")
        
    }
 
    
    func configureWithUI() {
        guard let habit = self.habit else {return}
        
        goalTitleLabel.text = "목표: \(habit.goalTitle!)"
        acheiveCountLabel.text = "습관 완료 : \(habit.acheiveCount)회"
        
        if let createdDate = habit.createdDateStr {
            createdDateLabel.text = createdDate + "~"

        }
        
        if let percent = habit.percent {
            cheerLabel.text = CheerUp.ment(percent: Int(percent))
            let percentStr = String(Int(percent)) + "%"
            
            circularProgressView.setprogress(0.0, UIColor(red:0.14, green:0.60, blue:0.23, alpha:1.0), percentStr, "\(habit.goalCount - habit.acheiveCount)번 남음")
            circularProgressView.animate(Double(percent) / 100, duration: 1)
        }
        
        
        if (habit.acheiveCount == habit.goalCount) {
            acheiveButton.setTitle("잔디 완성하기🪴", for: .normal)
        }


        
    }
    @IBAction func acheiveButtonTapped(_ sender: UIButton) {
        
        guard let habit = self.habit else {return}
        habit.acheiveCount += 1
        // 참고    https://github.com/huri000/SwiftEntryKit#dismissing-an-entry
        // Generate top floating entry and set some properties
        var attributes = EKAttributes.centerFloat
        // 배경
//        attributes.entryBackground = .color(color: .standardContent)
        attributes.entryBackground = .visualEffect(style: .dark)
        attributes.screenBackground = .color(color: EKColor(UIColor(white: 0.5, alpha: 0.5)))
        // 지속시간
        attributes.displayDuration = .infinity
        // 디스미스 시키기
        attributes.entryInteraction = .dismiss
        attributes.screenInteraction = .forward
        // 키보드 관련
        let offset = EKAttributes.PositionConstraints.KeyboardRelation.Offset(bottom: 10, screenEdgeResistance: 20)
        let keyboardRelation = EKAttributes.PositionConstraints.KeyboardRelation.bind(offset: offset)
        attributes.positionConstraints.keyboardRelation = keyboardRelation
//        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor(.red), EKColor(.green)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))

        self.showSignupForm(attributes: &attributes, style: .metallic, habit: habit)

//        self.navigationController?.popViewController(animated: true)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension DetailViewController {
    
    
    // Sign up form
    private func showSignupForm(attributes: inout EKAttributes, style: FormStyle, habit: Habit) {
        let titleStyle = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 14),
            color: style.textColor,
            displayMode: attributes.displayMode
        )
        let title = EKProperty.LabelContent(
            text: "기록",
            style: titleStyle
        )
        let textFields = FormFieldPresetFactory.fields(
            //            by: [.fullName, .mobile, .email, .password],
            by: [.memo],
            style: style
        )
        let button = EKProperty.ButtonContent(
            label: .init(text: "완료", style: style.buttonTitle),
            backgroundColor: style.buttonBackground,
            highlightedBackgroundColor: style.buttonBackground.with(alpha: 0.8),
            displayMode: .inferred) {
                SwiftEntryKit.dismiss()
            }
        let contentView = EKFormMessageView(
            with: title,
            textFieldsContent: textFields,
            buttonContent: button
        )
        attributes.lifecycleEvents.didAppear = {
            contentView.becomeFirstResponder(with: 0)
        }
        
        attributes.lifecycleEvents.willDisappear = {
            print()
            self.coreDataManager.updateData(newData: habit) {
                print("habit 업데이트 완료")
            }
            self.coreDataManager.saveAcheiveData(habit: habit, memo: contentView.getText(with: 0)) {
                print("acheive 업데이트 완료")
            }
            self.configureWithUI()
            
        }
        SwiftEntryKit.display(entry: contentView, using: attributes, presentInsideKeyWindow: true)
    }
    
}
