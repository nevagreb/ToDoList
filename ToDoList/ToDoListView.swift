//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject private var toDoList = ToDoList()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            listOfNotes
            .navigationTitle("Задачи")
            .safeAreaInset(edge: .bottom) {
                    bottomBar
                }
        }
        .searchable(text: $searchText, 
                    placement: .toolbar)
    }
    
    private var listOfNotes: some View {
        List {
            ForEach(toDoList.notes) { note in
                ToDoItemView(note: note,
                             tapAction: { selectNote(with: note.id) })
            }
        }
        .listStyle(.plain)
    }
    
    private var bottomBar: some View {
        ZStack {
            HStack {
                Spacer()
                Text(toDoList.notes.count.numberToStingInTasks())
                Spacer()
            }
            newNoteButton
            
        }
        .padding()
        .background(Color.customGray)
    }
    
    private var newNoteButton: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                Image("newNote")
            }
        }
    }
    
    private func selectNote(with id: UUID) {
        toDoList.selectNote(with: id)
    }
}

#Preview {
    ToDoListView()
        .preferredColorScheme(.dark)
}
