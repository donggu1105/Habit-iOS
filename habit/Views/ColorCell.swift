//
//  ColorCell.swift
//  habit
//
//  Created by web_dev on 2023/01/09.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    
    var color: MyColor? {
        didSet {
            configureUI()
        }
    }
    
    func configureUI() {
        self.backgroundColor = color?.backgoundColor
    }
}
