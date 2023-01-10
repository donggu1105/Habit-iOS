//
//  LSHContributionHelper.swift
//  habit
//
//  Created by web_dev on 2023/01/05.
// https://iosexample.com/perfect-contributions-view-with-swift/
import LSHContributionView
extension LSHContributionView {
    
    // MARK: - 기본 디폴트 데이터 square 만들기
    static func makeDefaultSquareData() -> [[Int]] {
        
        var dataSquare: [[Int]] = []
        var subArr: [Int] = []
        for _ in 0...4 {
            for _ in 1...Goal.grassX {
                subArr.append(0)
            }
            dataSquare.append(subArr)
            subArr = []
        }
        
        return dataSquare
    }
    
}
