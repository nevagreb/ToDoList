//
//  Note.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import Foundation

struct NotesList: Codable {
    var todos: [Note] = []
    
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

