//
//  TodoList.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import Foundation

class ToDoList: ObservableObject {
    @Published var notesList = NotesList()
    @Published var isFetching = false
    
    var notes: [NotesList.Note] {
        notesList.todos
    }
    // MARK: - Intent(s)

    func selectNote(with id: Int) {
        notesList.markNoteAsDone(with: id)
    }
    
    func findIndex(of id: Int) -> Int? {
        notesList.findIndex(of: id)
    }
    
    func addNewNote() {
        notesList.addNote()
    }
    
    func deleteNote(with id: Int) {
        notesList.deleteNote(with: id)
    }
    
    @MainActor
    func featchData() async {
        isFetching = true
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(NotesList.self, from: data) {
                    self.notesList = decodedResponse
                    self.isFetching = false
            }
        } catch {
            print("Invalid data")
        }
    }
}
