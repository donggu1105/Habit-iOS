//
//  Habit+CoreDataProperties.swift
//  
//
//  Created by 강동현 on 2023/01/10.
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
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var acheive: NSOrderedSet?
    
    
    var createdDateStr: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.createdDate else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
    
    var percent: Double? {
        let percent = Double(self.acheiveCount) / Double(self.goalCount) * 100
        return percent
    }

}

// MARK: Generated accessors for acheive
extension Habit {

    @objc(insertObject:inAcheiveAtIndex:)
    @NSManaged public func insertIntoAcheive(_ value: Acheive, at idx: Int)

    @objc(removeObjectFromAcheiveAtIndex:)
    @NSManaged public func removeFromAcheive(at idx: Int)

    @objc(insertAcheive:atIndexes:)
    @NSManaged public func insertIntoAcheive(_ values: [Acheive], at indexes: NSIndexSet)

    @objc(removeAcheiveAtIndexes:)
    @NSManaged public func removeFromAcheive(at indexes: NSIndexSet)

    @objc(replaceObjectInAcheiveAtIndex:withObject:)
    @NSManaged public func replaceAcheive(at idx: Int, with value: Acheive)

    @objc(replaceAcheiveAtIndexes:withAcheive:)
    @NSManaged public func replaceAcheive(at indexes: NSIndexSet, with values: [Acheive])

    @objc(addAcheiveObject:)
    @NSManaged public func addToAcheive(_ value: Acheive)

    @objc(removeAcheiveObject:)
    @NSManaged public func removeFromAcheive(_ value: Acheive)

    @objc(addAcheive:)
    @NSManaged public func addToAcheive(_ values: NSOrderedSet)

    @objc(removeAcheive:)
    @NSManaged public func removeFromAcheive(_ values: NSOrderedSet)

}
