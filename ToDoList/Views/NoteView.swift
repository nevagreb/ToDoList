//
//  NoteView.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

// структура - детальный экран заметки
struct NoteView: View {
    @ObservedObject var note: ToDoNote
    @EnvironmentObject var router: Router
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var date: Date = .now

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Название заметки", text: $title)
                .font(Font.system(size: 34, weight: .bold))
                .padding(.bottom, 8)
            Text(date.formattedAsShortDate())
                .font(Font.system(size: 12))
                .opacity(0.5)
                .padding(.bottom, 8)
            noteText
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            self.title = note.title
            self.text = note.text
            self.date = note.date
        }
        .onDisappear {
            if isNoteEmpty() {
                delete()
            } else {
                edit()
            }
            do {
                try note.managedObjectContext?.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // текст эдитор для текста заметки с кастомным плэйсхолдером
    private var noteText: some View {
        ZStack (alignment: .topLeading) {
            if text.isEmpty {
                Text("Введите текст заметки")
                    .foregroundColor(Color(uiColor: .placeholderText))
            }
            TextEditor(text: $text)
                .opacity(text.isEmpty ? 0.1 : 1)
        }
        .font(Font.system(size: 16))
    }
    
    // кастомная кнопка возвращения назад 
    private var backButton: some View {
        Button(action: router.goBack) {
            HStack {
                Image("chevron")
                Text("Назад")
                    .foregroundStyle(.yellow)
            }
        }
    }
    
    // проверка на пустую заметку для удаления
    private func isNoteEmpty() -> Bool {
        title.isEmpty && text.isEmpty
    }
    
    // функция удаления заметки
    private func delete() {
        withAnimation {
            managedObjectContext.delete(note)
            managedObjectContext.saveContext()
        }
    }
    
    // функция редактирования заметки
    private func edit() {
        withAnimation {
            note.wrappedTitle = title
            note.wrappedText = text
            managedObjectContext.saveContext()
        }
    }
}
