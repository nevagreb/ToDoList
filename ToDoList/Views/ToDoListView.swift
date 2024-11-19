//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

struct ToDoListView: View {
    @EnvironmentObject var toDoList: ToDoList
    @EnvironmentObject var router: Router
    @State private var searchText = ""

    var body: some View {
        listOfNotes
            .navigationTitle("Задачи")
            .safeAreaInset(edge: .bottom) {
                bottomBar
            }
            .searchable(text: $searchText,
                        placement: .toolbar)
    }
    
    private var listOfNotes: some View {
        List {
            ForEach(toDoList.notes) { note in
                ToDoItemView(note: note,
                             tapAction: { selectNote(with: note.id) })
                .onTapGesture(count: 1) {
                    router.navigate(to: note)
                }
                .contextMenu {
                    ContexMenuButton(type: .edit,
                                     action: { router.navigate(to: note) })
                    ContexMenuButton(type: .share,
                                     action: {})
                    ContexMenuButton(type: .delete,
                                     action: { toDoList.deleteNote(with: note.id) })
                }
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
            Button(action: createNewNote ) {
                Image("newNote")
            }
        }
    }
    
    private func createNewNote() {
        toDoList.addNewNote()
        if let note = toDoList.notes.last {
            router.navigate(to: note)
        }
    }
    
    private func selectNote(with id: UUID) {
        toDoList.selectNote(with: id)
    }
}

