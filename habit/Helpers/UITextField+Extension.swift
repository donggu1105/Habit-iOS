//
//  UITextField+Extension.swift
//  habit
//
//  Created by web_dev on 2023/01/09.
//
import UIKit

extension UITextField {
    func isValid(with word: String) -> Bool {
        guard let text = self.text,
              !text.isEmpty else {
            print("Please fill the field.")
            return false
        }

//        guard text.contains(word) else {
//            print("Wrong word. Please check again.")
//            return false
//        }

        return true
    }
}
