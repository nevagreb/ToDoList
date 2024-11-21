//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

struct ToDoListView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\ToDoNote.wrappedDate, order: .reverse)])
    private var todos: FetchedResults<ToDoNote>
    @EnvironmentObject var router: Router
    @EnvironmentObject private var toDoList: ToDoList
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var searchText = ""
    
    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            let p1 = NSPredicate(format: "wrappedTitle CONTAINS %@", newValue)
            let p2 = NSPredicate(format: "wrappedText CONTAINS %@", newValue)
            searchText = newValue
            todos.nsPredicate = newValue.isEmpty
            ? nil
            : NSCompoundPredicate(orPredicateWithSubpredicates: [p1, p2])
        }
    }

    var body: some View {
        VStack {
            if toDoList.isFetching {
                ProgressView()
                Spacer()
            } else {
                listOfNotes
                    .onAppear {
                        if todos.isEmpty {
                            addNotesFromServer()
                        }
                    }
            }
        }
        .navigationTitle("Задачи")
        .safeAreaInset(edge: .bottom) {
            bottomBar
        }
        .searchable(text: query,
                    placement: .toolbar)
        .task {
            if todos.isEmpty {
                await toDoList.featchData()
            }
        }
        // TODO: - DELETE
//        .toolbar {
//            ToolbarItem {
//                Button("Delete") {
//                    todos.forEach { note in
//                        managedObjectContext.delete(note)
//                        managedObjectContext.saveContext()
//                    }
//                }
//            }
//        }
    }
    
    private var listOfNotes: some View {
        List {
            ForEach(todos) { note in
                ToDoItemView(note: note,
                             tapAction: { select(note: note) })
                .onTapGesture(count: 1) {
                    router.navigate(to: note)
                }
                .contextMenu {
                    ContexMenuButton(type: .edit,
                                     action: { router.navigate(to: note) })
                    ContexMenuButton(type: .share,
                                     action: {})
                    ContexMenuButton(type: .delete,
                                     action: { delete(note: note) })
                }
            }
        }
        .listStyle(.plain)
    }
    
    private var bottomBar: some View {
        ZStack {
            HStack {
                Spacer()
                Text(todos.count.numberToStingInTasks())
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
            Button(action: addNote ) {
                Image("newNote")
            }
        }
    }
    
    private func addNote() {
        withAnimation {
            let newNote = ToDoNote(context: managedObjectContext)
            newNote.createEmptyNote()
            managedObjectContext.saveContext()
            router.navigate(to: newNote)
        }
    }
    
    private func delete(note: ToDoNote) {
        withAnimation {
            managedObjectContext.delete(note)
            managedObjectContext.saveContext()
        }
    }
    
    private func select(note: ToDoNote) {
        withAnimation {
            note.wrappedIsDone.toggle()
            managedObjectContext.saveContext()
        }
    }
    
    func addNotesFromServer() {
        toDoList.notesList.todos.forEach {
            let newNote = ToDoNote(context: managedObjectContext)
            newNote.addInfo(from: $0)
        }
    }
}

