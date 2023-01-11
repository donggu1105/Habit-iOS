//
//  Acheive+CoreDataProperties.swift
//  
//
//  Created by web_dev on 2023/01/11.
//
//

import Foundation
import CoreData


extension Acheive {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Acheive> {
        return NSFetchRequest<Acheive>(entityName: "Acheive")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var level: Int64
    @NSManaged public var memo: String?
    @NSManaged public var habit: Habit?

    var createdDateStr: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.createdDate else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}
