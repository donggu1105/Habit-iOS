//
//  Constant.swift
//  habit
//
//  Created by web_dev on 2023/01/09.
//

import UIKit


public struct Entity {
    static let habit: String = "Habit"
    static let acheive: String = "Acheive"
}

public class CheerUp {
    
    public static func ment(percent: Int) -> String {
        switch percent {
        case 1...5: return "시작이 좋군요! 잘하고 있어요."
        case 6...10: return "10% 만 딱 채워보기 도전!"
        case 11...20: return "뭔가를 꾸준히 한다는건 대단한 일이에요!"
        case 21...30: return "벌써 잔디가 많이 심어 졌어요!"
        case 31...50: return "멋지네요! 목표에 한발짝 더 다가 섰어요."
        case 51...80: return "슬슬 습관이 되어가는것 같아요~"
        case 81...99: return "고지가 눈앞이다!"
        case 100: return "잔디를 모두 채우느라 고생하셨어요!"
        default:  return "시작이 중요한법! 첫 잔디를 심어볼까요?"
            
        }
    }
}
