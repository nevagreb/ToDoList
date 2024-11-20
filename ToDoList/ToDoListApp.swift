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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
//        .onChange(of: scenePhase) {
//              persistenceController.save()
//          }
    }
}
