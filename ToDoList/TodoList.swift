//
//  TodoList.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import Foundation

class ToDoList: ObservableObject {
    @Published var notesList = NotesList()
    
    var notes: [NotesList.Note] {
        notesList.notes
    }
    // MARK: - Intent(s)

    func selectNote(with id: UUID) {
        notesList.selectNote(with: id)
    }
}
