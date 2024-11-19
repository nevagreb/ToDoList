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
        notesList.markNoteAsDone(with: id)
    }
    
    func findIndex(of id: UUID) -> Int? {
        notesList.findIndex(of: id)
    }
    
    func addNewNote() {
        notesList.addNote()
    }
    
    func deleteNote(with id: UUID) {
        notesList.deleteNote(with: id)
    }
}
