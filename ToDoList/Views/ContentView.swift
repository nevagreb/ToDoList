//
//  ContentView.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var toDoList = ToDoList()
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            ToDoListView()
                .navigationDestination(for: ToDoNote.self) { note in
                    NoteView(note: note)
                }
        }
        .environmentObject(toDoList)
        .environmentObject(router)
    }
}
