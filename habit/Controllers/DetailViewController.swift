//
//  DetailViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var golaTextField: UITextField!
    
    @IBOutlet weak var acheiveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
    }
    
    @IBAction func acheiveButtonTapped(_ sender: UIButton) {
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
