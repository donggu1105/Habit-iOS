//
//  DetailViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class DetailViewController: UIViewController {

    let coreDataManager = CoreDataManager.shared

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var golaTextField: UITextField!
    @IBOutlet weak var acheiveButton: UIButton!
    @IBOutlet weak var animatedCountingLabel: UILabel!
    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 2
    
    var name: String? {
        didSet {
            nameTextField.text = name
        }
    }
    
    var goalTitle: String? {
        didSet {
            golaTextField.text = goalTitle
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        setUp()
        setUpCircularProgressBarView()
    }
    
    func setUp() {
        // 버튼
        acheiveButton.clipsToBounds = true
        acheiveButton.layer.cornerRadius = 8
        acheiveButton.setTitle("잔디 심기", for: .normal)

        
    }
    
//    func setUpNavi() {
//        self.title = "잔디 상세 보기"
//        let menuButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(plusButtonTapped))
//        menuButton.tintColor = .black
//        navigationItem.rightBarButtonItem = menuButton
//    }
//
//    @objc func plusButtonTapped() {
//        print(#function)
//    }
    
    func setUpCircularProgressBarView() {
        // set view
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        // align to the center of the screen
        circularProgressBarView.center = view.center
        // call the animation with circularViewDuration
        circularProgressBarView.progressAnimation(duration: circularViewDuration)
        // add this view to the view controller
        view.addSubview(circularProgressBarView)
    }
    
    @IBAction func acheiveButtonTapped(_ sender: UIButton) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
