//
//  Note.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import Foundation

struct NotesList {
    private(set) var notes: [Note] = []
    
    init() {
        notes.append(Note(title: "Прочитать книгу",
                          description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
                          date: .now,
                          isSelected: true))
        notes.append(Note(title: "Прочитать книгу",
                          description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
                          date: .now,
                          isSelected: false))
        notes.append(Note(title: "Прочитать книгу",
                          description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
                          date: .now,
                          isSelected: false))
    }
    
    func findIndex(of id: UUID) -> Int? {
        notes.firstIndex(where: {id == $0.id})
    }
    
    mutating func selectNote(with id: UUID) {
        if let index = findIndex(of: id) {
            notes[index].isSelected.toggle()
        }
    }
    
    struct Note: Identifiable {
        var title: String
        var description: String
        var date: Date
        var isSelected: Bool
        var id: UUID = UUID()
    }
}
