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
    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
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

//         네비게이션바 우측에 Plus 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .red
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func plusButtonTapped() {
        performSegue(withIdentifier: "register", sender: nil)
    }


}



extension ViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return coreDataManager.getHabitList().count
//    }
    //지정된 섹션에 표시할 항목의 개수를 묻는 메서드.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataManager.getHabitList().count
    }
    //컬렉션뷰의 지정된 위치에 표시할 셀을 요청하는 메서드.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCell", for: indexPath) as! HabitCell
        
        // 셀에 모델(ToDoData) 전달
        let habitData = coreDataManager.getHabitList()
        cell.habitData = habitData[indexPath.row]
        return cell
    }
}

extension ViewController:UICollectionViewDelegate {
    //지정된 셀이 선택되었음을 알리는 메서드.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: indexPath)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let detailVC = segue.destination as! DetailViewController
            
            guard let indexPath = sender as? IndexPath else { return }
            detailVC.habitData = coreDataManager.getHabitList()[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            return footer
        } else {
            return UICollectionReusableView()
        }
    }
    
    
}

