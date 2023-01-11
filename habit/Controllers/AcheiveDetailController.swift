

import UIKit

class AcheiveDetailController: UIViewController {
    
    var habit: Habit?
    
    let coreDataManager = CoreDataManager.shared



    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureWithUI()

    }
    
    func setUp() {
        self.view.backgroundColor = .black

    }
    
    func configureWithUI() {
        
        guard let habit = self.habit else { return }
        
        print(coreDataManager.getAcheiveList(habit: habit)[0].memo
        )
        // Do any additional setup after loading the view.
        
    }
    



}
