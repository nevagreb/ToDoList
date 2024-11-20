//
//  CoreDataResult.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 19.11.2024.
//

import SwiftUI

struct CoreDataResult: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<NoteEntity>
    
    var body: some View {
        ZStack {
            List(students) { l in
                Text(l.title ?? "No name")
            }
            
            VStack {
                Spacer()
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let one = NoteEntity(context: managedObjectContext)
                    one.id = 1
                    one.title = "One"
                    one.isDone = false
                    
                    let two = NoteEntity(context: managedObjectContext)
                    two.id = 2
                    two.title = "Two"
                    two.isDone = false
                    
                    try? managedObjectContext.save()
                }
            }
        }
        .navigationTitle("LLA")
    }
}

