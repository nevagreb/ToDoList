//
//  TodoList.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import Foundation

// класс - вьюмодель для работы с сетью
class ToDoList: ObservableObject {
    @Published var notesList = NotesList()
    @Published var isFetching = false
    
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
