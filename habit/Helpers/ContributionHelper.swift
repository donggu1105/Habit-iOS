//
//  LSHContributionHelper.swift
//  habit
//
//  Created by web_dev on 2023/01/05.
// https://iosexample.com/perfect-contributions-view-with-swift/
//import LSHContributionView
final class ContributionHelper {
    
    private static let row: Int = 5
    private static let col: Int = 8
    private static var subArr: [Int] = {
        var array: [Int] = []
        for _ in 0..<ContributionHelper.col {
            array.append(0)
        }
        return array
    }()
    private static var defaultDataSquare: [[Int]] = {
        var dataSquare: [[Int]] = []

        for _ in 0..<ContributionHelper.row {
            dataSquare.append(ContributionHelper.subArr)
        }
        return dataSquare
    }()
   
    public static func getDataSqureByAchieveCount(acheiveCount: Int) -> [[Int]] {
        
        var dataSquare: [[Int]] = ContributionHelper.defaultDataSquare
        
        let y = acheiveCount / Goal.grassX // 몫
        let x = acheiveCount % Goal.grassX // 나머지
        
        
        for row in 0..<y {
            dataSquare[row] = [3,3,3,3,3,3,3,3]
        }
        
        for col in 0..<x {
            dataSquare[y][col] = 3
        }
        
        return dataSquare
        
    }
    
    // MARK: - 기본 디폴트 데이터 square 만들기
//    static func makeDefaultSquareData() -> [[Int]] {
//
//        var dataSquare: [[Int]] = []
//        var subArr: [Int] = []
//        for _ in 0...4 {
//            for _ in 0..<Goal.grassX {
//                subArr.append(0)
//            }
//            dataSquare.append(subArr)
//            subArr = []
//        }
//
//        return dataSquare
//    }
    
    
//    static func makeData(acheiveCount: Int) -> [[Int]] {
//        var dataSquare: [[Int]] = LSHContributionView.makeDefaultSquareData()
//        var subArr: [Int] = []
//
//        if acheiveCount == 0 {
//            return LSHContributionView.makeDefaultSquareData()
//        }
//
////        var iterCnt = 0
//        let x = acheiveCount % Goal.grassX // 나머지
//        let y = acheiveCount / Goal.grassX // 몫
//
//
//        if (y == 0) {
//            for test in 0..<acheiveCount {
//                dataSquare[0][test] = 3
//            }
//        }
//
//
//        for v in 0...4 {
//            for h in 0...Goal.grassX {
//                if (y == 0) { // 첫줄 일경우
//                    if (h <= x) {
//                        subArr.append(3)
//                    } else {
//                        subArr.append(0)
//                    }
//
//                } else if (y == 1) {
//
//                } else if (y == 2) {
//
//                } else if (y == 3) {
//
//                }
////                subArr.append(3)
//            }
//            dataSquare.append(subArr)
//            subArr = []
//        }
//
//
//        return dataSquare
//    }
//
//
//    static func makeData2(acheiveCount: Int) -> [[Int]] {
//        var dataSquare: [[Int]] = []
//        var subArr: [Int] = []
//
//        var iterCnt = 0
//        let x = acheiveCount % Goal.grassX // 나머지
//        let y = acheiveCount / Goal.grassX // 몫
//
//
//
//        for v in 0...4 {
//            for h in 0...Goal.grassX {
//                if (y == 0) { // 첫줄 일경우
//                    if (h <= x) {
//                        subArr.append(3)
//                    } else {
//                        subArr.append(0)
//                    }
//
//                } else if (y == 1) {
//
//                } else if (y == 2) {
//
//                } else if (y == 3) {
//
//                }
////                subArr.append(3)
//            }
//            dataSquare.append(subArr)
//            subArr = []
//        }
//
//        return dataSquare
//    }
//
//    func colorWithAcheiveCount(acheiveCount: Int) {
//
//
//        var iterCnt = 0
//        let x = acheiveCount % Goal.grassX // 나머지
//        let y = acheiveCount / Goal.grassX // 몫
//
//
//        repeat {
////            print("acheiveCount: \(acheiveCount)")
////            print("x: \(x) , y: \(y), iterCnt: \(iterCnt)")
//            if (iterCnt < y) {
//                for color in 0..<Goal.grassX {
//
////                    contributionView.addEntry(with: CGPoint(x: color, y: iterCnt), level: 3)
//                }
//            } else {
////                print("줄바뀜")
//                for color in 0..<x {
////                    contributionView.addEntry(with: CGPoint(x: color, y: iterCnt), level: 3)
//                }
//            }
//            iterCnt += 1
//        } while (iterCnt <= y)
//    }
}
