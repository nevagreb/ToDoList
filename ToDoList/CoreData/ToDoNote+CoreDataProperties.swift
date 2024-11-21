//
//  ToDoNote+CoreDataProperties.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 21.11.2024.
//
//

import Foundation
import CoreData


extension ToDoNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoNote> {
        return NSFetchRequest<ToDoNote>(entityName: "ToDoNote")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?

}

extension ToDoNote : Identifiable {

}
