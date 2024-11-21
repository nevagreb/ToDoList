//
//  ToDoNote+CoreDataProperties.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 21.11.2024.
//
//

import Foundation
import CoreData

// объект CoreData
extension ToDoNote {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoNote> {
        return NSFetchRequest<ToDoNote>(entityName: "ToDoNote")
    }

    @NSManaged public var wrappedId: Int16
    @NSManaged public var wrappedTitle: String?
    @NSManaged public var wrappedText: String?
    @NSManaged public var wrappedDate: Date?
    @NSManaged public var wrappedIsDone: Bool
    @NSManaged public var wrappedUserId: Int16
}

// расширение используется для вычисления не Optional
// переменных для работы в UI
extension ToDoNote : Identifiable {
    public var id: Int {
        Int(wrappedId)
    }
    var title: String {
        wrappedTitle ?? ""
    }
    var text: String {
        wrappedText ?? ""
    }
    var date: Date {
        wrappedDate ?? .now
    }
    var isDone: Bool {
        wrappedIsDone
    }
    var userId: Int {
        Int(wrappedUserId)
    }
    
    // MARK: - Intent(s)
    // функция присваивает нулевые значения объекту
    func createEmptyNote() {
        self.wrappedId = 100
        self.wrappedTitle = ""
        self.wrappedText = ""
        self.wrappedDate = .now
        self.wrappedIsDone = false
        self.wrappedUserId = 100
    }
    
    func addInfo(from note: NotesList.Note) {
        self.wrappedId = Int16(note.id)
        self.wrappedTitle = note.title
        self.wrappedText = note.description
        self.wrappedDate = note.date
        self.wrappedIsDone = note.isDone
        self.wrappedUserId = Int16(note.userId)
    }
}

