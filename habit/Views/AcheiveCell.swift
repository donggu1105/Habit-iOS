import UIKit

final class AcheiveCell: UICollectionViewCell {

    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!

    
    var data: Acheive? {
        didSet {
            configureUIwithData()
        }
    }

    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        
        // 셀 모양 셋업
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor(hexString: "f6bd60")
//        self.contentView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        self.contentView.layer.cornerRadius = 8
//        self.contentView.layer.borderWidth = 1
        
        if let createdDate = data?.createdDateStr {
            createdDateLabel.text = "\(createdDate)"
        }
        
        
        memoLabel.text = data?.memo
    }
  

}
