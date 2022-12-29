//
//  ViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 코어데이터
    let coreDataManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .darkGray
        
        // 네비게이션 셋업
        setupNaviBar()
        setupCollectionView()
            
    }
    
    func setupNaviBar() {
        self.title = "잔디 목록"
        
        // 네비게이션바 타이틀 크게
//        navigationController?.navigationBar.prefersLargeTitles = true
        // 네비게이션바 타이틀 중앙
//        navigationItem.largeTitleDisplayMode = .never

        // 네비게이션바 우측에 Plus 버튼 만들기
//        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
//        plusButton.tintColor = .black
//        navigationItem.rightBarButtonItem = plusButton
    }
    
    func setupCollectionView() {
        
    }


}



extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return coreDataManager.getHabitList().count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section != coreDataManager.getHabitList().count {
            //without button Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCell", for: indexPath) as! HabitCell
            return cell
        } else {
            //with button Cell like setting Click
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCell", for: indexPath) as! HabitCell
            return cell
        }
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 5 {
            //open your viewController in which you want to setting view like.
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return UICollectionViewFlowLayout.automaticSize
        
    }
}

