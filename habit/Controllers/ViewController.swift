//
//  ViewController.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 코어데이터
    let coreDataManager = CoreDataManager.shared
    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        // 네비게이션 셋업
        setupNaviBar()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .red
        // 테이블뷰의 선 없애기
        tableView.separatorStyle = .none
    }
    
    func setupNaviBar() {

        self.title = "잔디 목록"
        
        // 네비게이션바 타이틀 크게
//        navigationController?.navigationBar.prefersLargeTitles = true
        // 네비게이션바 타이틀 중앙
//        navigationItem.largeTitleDisplayMode = .never

//      네비게이션바 우측에 Plus 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = plusButton
        
    }
    
    @objc func plusButtonTapped() {
        performSegue(withIdentifier: "register", sender: nil)
    }

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.getHabitList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitCell
        // 셀에 모델(ToDoData) 전달
        let habitData = coreDataManager.getHabitList()
        cell.data = habitData[indexPath.row]
        
        // 셀위에 있는 버튼이 눌렸을때 (뷰컨트롤러에서) 어떤 행동을 하기 위해서 클로저 전달
//        cell.updateButtonPressed = { [weak self] (senderCell) in
//            // 뷰컨트롤러에 있는 세그웨이의 실행
//            self?.performSegue(withIdentifier: "ToDoCell", sender: indexPath)
//        }
        
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        print(indexPath)
        performSegue(withIdentifier: "detail", sender: indexPath)
    }
    
    // (세그웨이를 실행할때) 실제 데이터 전달 (ToDoData전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        if segue.identifier == "detail" {
            print("detail")
            let detailVC = segue.destination as! DetailViewController
            
            guard let indexPath = sender as? IndexPath else { return }
            detailVC.habitData = coreDataManager.getHabitList()[indexPath.row]
        } else if segue.identifier == "register" {
            print("register")
        }
    }
    
    // 테이블뷰의 높이를 자동적으로 추청하도록 하는 메서드
    // (ToDo에서 메세지가 길때는 셀의 높이를 더 높게 ==> 셀의 오토레이아웃 설정도 필요)
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}






