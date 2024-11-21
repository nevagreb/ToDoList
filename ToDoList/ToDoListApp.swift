//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //CoreView()
            ContentView()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {
            persistenceController.container.viewContext.saveContext()
        }
    }
}
