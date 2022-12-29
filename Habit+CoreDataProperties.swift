//
//  Habit+CoreDataProperties.swift
//  habit
//
//  Created by web_dev on 2022/12/29.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var acheiveCount: Int64
    @NSManaged public var color: Int64
    @NSManaged public var createdDate: Date?
    @NSManaged public var goalCount: Int64
    @NSManaged public var goalTitle: String?
    @NSManaged public var name: String?
    @NSManaged public var percent: Int64
    
    var createdDateStr: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let createdDate = self.createdDate else { return "" }
        let savedDateString = myFormatter.string(from: createdDate)
        return savedDateString
    }
    
    var percentStr: String? {
        
        return String(percent) + "%"
        
        
    }
    

}

extension Habit : Identifiable {

}
