//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

struct ToDoListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.wrappedTitle)])
    var todos: FetchedResults<ToDoNote>
    
    //@EnvironmentObject var toDoList: ToDoList
    @EnvironmentObject var router: Router

    @State private var searchText = ""

    var body: some View {
        VStack {
//            if toDoList.isFetching {
//                ProgressView()
//                Spacer()
//            } else {
                listOfNotes
            //}
        }
        .navigationTitle("Задачи")
        .safeAreaInset(edge: .bottom) {
            bottomBar
        }
        .searchable(text: $searchText,
                    placement: .toolbar)
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
}

