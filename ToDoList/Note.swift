//
//  Note.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import Foundation

struct NotesList: Codable {
    var todos: [Note] = []
    
    func findIndex(of id: Int) -> Int? {
        todos.firstIndex(where: {id == $0.id})
    }
    
    mutating func markNoteAsDone(with id: Int) {
        if let index = findIndex(of: id) {
            todos[index].isDone.toggle()
        }
    }
    
    mutating func addNote() {
        let newNote = NotesList.Note(id: todos.reduce(0) { $0 + $1.id },
                                     title: "",
                                     _description: "",
                                     _date: .now,
                                     isDone: false,
                                     userId: 0)
        todos.append(newNote)
    }
    
    mutating func deleteNote(with id: Int) {
        if let index = findIndex(of: id) {
            todos.remove(at: index)
        }
    }
    
    struct Note: Identifiable, Hashable, Codable {
        var id: Int
        var title: String
        var _description: String?
        var _date: Date?
        var isDone: Bool
        var userId: Int
        
        var description: String {
            if let _description = _description {
                return _description
            } else {
                return ""
            }
        }
        var date: Date {
            if let _date = _date {
                return _date
            } else {
                return .now
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case title = "todo"
            case _description
            case _date
            case isDone = "completed"
            case userId
        }
    }
}

