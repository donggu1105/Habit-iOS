
final class ContributionHelper {
    
    private static let row: Int = 5
    private static let col: Int = 8
    public static let goalCount: Int = {
        let goalCount = ContributionHelper.row * ContributionHelper.col
        return goalCount
    }()
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

  
        
        let y = acheiveCount / ContributionHelper.col // 몫
        let x = acheiveCount % ContributionHelper.col // 나머지
        
        
        if (y >= ContributionHelper.col) { return
            [
                [3,3,3,3,3,3,3,3],
                [3,3,3,3,3,3,3,3],
                [3,3,3,3,3,3,3,3],
                [3,3,3,3,3,3,3,3],
                [3,3,3,3,3,3,3,3]
            ]
            
        }
        
        for row in 0..<y {
            dataSquare[row] = [3,3,3,3,3,3,3,3]
        }
        
        for col in 0..<x {
            dataSquare[y][col] = 3
        }
        
        return dataSquare
        
    }
 
}
