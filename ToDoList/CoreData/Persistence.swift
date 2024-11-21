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

    // конфигурация для превью
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        // тестовые данные
        var id = 0
        for _ in 0..<10 {
            let todo = ToDoNote(context: controller.container.viewContext)
            todo.title = "Example Language 1"
            todo.id = Int16(id)
            id += 1
        }

        return controller
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ToDoNotes")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

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
