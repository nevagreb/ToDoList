//
//  Note.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import Foundation

struct NotesList {
    var notes: [Note] = []
    
    init() {
        notes.append(Note(title: "Прочитать книгу",
                          description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
                          date: .now,
                          isDone: true))
        notes.append(Note(title: "Прочитать книгу",
                          description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
                          date: .now,
                          isDone: false))
        notes.append(Note(title: "Прочитать книгу",
                          description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
                          date: .now,
                          isDone: false))
    }
    
    func findIndex(of id: UUID) -> Int? {
        notes.firstIndex(where: {id == $0.id})
    }
    
    mutating func markNoteAsDone(with id: UUID) {
        if let index = findIndex(of: id) {
            notes[index].isDone.toggle()
        }
    }
    
    mutating func addNote() {
        let newNote = NotesList.Note(title: "",
                                     description: "",
                                     date: .now,
                                     isDone: false)
        notes.append(newNote)
    }
    
    mutating func deleteNote(with id: UUID) {
        if let index = findIndex(of: id) {
            notes.remove(at: index)
        }
    }
    
    struct Note: Identifiable, Hashable {
        var title: String
        var description: String
        var date: Date
        var isDone: Bool
        var id: UUID = UUID()
    }
}
