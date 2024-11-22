//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

// структура - экран списка задач
struct ToDoListView: View {
    // фетчреквест для CoreData
    @FetchRequest(sortDescriptors: [SortDescriptor(\ToDoNote.wrappedDate, order: .reverse)])
    private var todos: FetchedResults<ToDoNote>
    @EnvironmentObject var router: Coordinator
    @EnvironmentObject private var toDoList: ToDoList
    // 2 контекста: 1 - работа с UI, 2 - работа в фоне
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.managedObjectContext) var backgroundContext
    @State private var searchText = ""
    
    // свойство используется для поиска по содержимому задачи
    // и ее описания
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
    }
    
    // список задач
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
    
    // боттомбар с количеством задач
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
    
    // кнопка добавления новой задачи
    private var newNoteButton: some View {
        HStack {
            Spacer()
            Button(action: addNote ) {
                Image("newNote")
            }
        }
    }
    
    // функция добавления новой задачи
    private func addNote() {
        withAnimation {
            let newNote = ToDoNote(context: managedObjectContext)
            newNote.createEmptyNote()
            backgroundContext.saveContext()
            router.navigate(to: newNote)
        }
    }
    
    // функция удаления
    private func delete(note: ToDoNote) {
        withAnimation {
            managedObjectContext.delete(note)
            backgroundContext.saveContext()
        }
    }
    
    // функция пометки задачи как выполненной
    private func select(note: ToDoNote) {
        withAnimation {
            note.wrappedIsDone.toggle()
            backgroundContext.saveContext()
        }
    }
    
    // функция загрузки задач с сервера
    private func addNotesFromServer() {
        toDoList.notesList.todos.forEach {
            let newNote = ToDoNote(context: managedObjectContext)
            newNote.addInfo(from: $0)
        }
    }
}

