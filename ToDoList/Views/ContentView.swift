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
                .navigationDestination(for: NotesList.Note.self) { note in
                    if let index = toDoList.findIndex(of: note.id) {
                        NoteView(note: $toDoList.notesList.todos[index])
                    }
                }
        }
        .environmentObject(router)
        .environmentObject(toDoList)
        .task {
            await toDoList.featchData()
        }
    }
}
