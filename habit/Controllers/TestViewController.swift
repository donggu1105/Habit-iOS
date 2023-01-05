//
//  TestViewController.swift
//  habit
//
//  Created by web_dev on 2023/01/05.
//

import UIKit
import LSHContributionView

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSquare = [
                    [0, 1, 2, 3, 4],
                    [1, 2, 3, 4, 3],
                    [2, 3, 4, 3, 2],
                    [3, 4, 3, 2, 1],
                    [4, 3, 2, 1, 0]
                ]
           
        let contributionView = LSHContributionView(frame: CGRect(x: 100, y: 100, width: 200, height: 180))
        contributionView.data = dataSquare
        contributionView.colorScheme = "Halloween"
        view.addSubview(contributionView)

    }


}
