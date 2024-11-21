//
//  Persistence.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 21.11.2024.
//

import CoreData

// структура - Persistence Controller
struct PersistenceController {
    // синглтон для использования контроллера
    static let shared = PersistenceController()
    // контейнер для Core Data
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ToDoNotes")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // функция созранения данных 
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save")
            }
        }
    }
}
