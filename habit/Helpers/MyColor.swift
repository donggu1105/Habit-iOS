//
//  MyColor.swift
//  MyToDoApp
//
//  Created by Allen H on 2022/04/21.
//

import UIKit

enum MyColor: Int64, CaseIterable {
    // main
    case defaultColor = 999
    // green
    case color1 = 0
    case color2 = 1
    case color3 = 2
    case color4 = 3
    case color5 = 4
    case color6 = 5
    case color7 = 6
    case color8 = 7
    case color9 = 8
    case color10 = 9
    case color11 = 10
    case color12 = 11
    case color13 = 12
    case color14 = 13
    case color15 = 14
//
    var backgoundColor: UIColor {
        switch self {
        case .defaultColor:
            return UIColor(hexString: "bc6c25")
        case .color1:
            return UIColor(hexString: "2640653")
        case .color2:
            return UIColor(hexString: "2a9d8f")
        case .color3:
            return UIColor(hexString: "588157")
        case .color4:
            return UIColor(hexString: "f28482")
        case .color5:
            return UIColor(hexString: "84a59d")
        case .color6:
            return UIColor(hexString: "f5cac3")
        case .color7:
            return UIColor(hexString: "fb5607")
        case .color8:
            return UIColor(hexString: "ff006e")
        case .color9:
            return UIColor(hexString: "00b4d8")
        case .color10:
            return UIColor(hexString: "0077b6")
        case .color11:
            return UIColor(hexString: "06d6a0")
        case .color12:
            return UIColor(hexString: "dda15e")
        case .color13:
            return UIColor(hexString: "bc6c25")
        case .color14:
            return UIColor(hexString: "b56576")
        case .color15:
            return UIColor(hexString: "861657")
//        default:
//            return UIColor(hexString: "bc6c25")
//        case .green5:
//            return UIColor(hexString: "344e41")
//        case .red:
//            //UIColor(hexString: "#EFD9D4")
//            return UIColor(red: 239/255, green: 217/255, blue: 212/255, alpha: 1)
//        case .green:
//            //UIColor(hexString: "#C2EDEA")
//            return UIColor(red: 194/255, green: 237/255, blue: 234/255, alpha: 1)
//        case .blue:
//            //UIColor(hexString: "#C4E4F2")
//            return UIColor(red: 196/255, green: 228/255, blue: 242/255, alpha: 1)
//        case .purple:
//            //UIColor(hexString: "#D4D4F5")
//            return UIColor(red: 212/255, green: 212/255, blue: 245/255, alpha: 1)
            
        }
    }
}
