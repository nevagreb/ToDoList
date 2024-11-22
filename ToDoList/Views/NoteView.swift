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
    @EnvironmentObject var router: Coordinator
    // 2 контекста: 1 - работа с UI, 2 - работа в фоне
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.managedObjectContext) var backgroundContext
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var date: Date = .now

    var body: some View {
        ScrollView {
            noteView
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .toolbar { keyboardDoneButton }
        .onAppear(perform: showNote)
        .onDisappear(perform: saveChanges)
    }
    
    // задача с тремя полями: заголовок, дата и описание
    var noteView: some View {
        VStack(alignment: .leading) {
            TextField("Название заметки", text: $title, axis: .vertical)
                .font(Font.system(size: 34, weight: .bold))
                .lineLimit(nil)
                .padding(.bottom, 8)
            Text(date.formattedAsShortDate())
                .font(Font.system(size: 12))
                .opacity(0.5)
                .padding(.bottom, 8)
            TextField("Введите текст заметки", text: $text, axis: .vertical)
                .font(Font.system(size: 16))
                .lineLimit(nil)
            Spacer()
        }
        .keyboardType(.alphabet)
        .disableAutocorrection(true)
        .padding()
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
    
    // кнопка Done для клавиатуры
    private var keyboardDoneButton: some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button(action: { hideKeyboard() }) {
                Text("Done")
                    .foregroundColor(Color.yellow)
                    .font(.body)
            }
        }
    }
    
    // проверка на пустую заметку для удаления
    private func isNoteEmpty() -> Bool {
        title.isEmpty && text.isEmpty
    }
    
    // функция для отображения данных заметки на экране
    private func showNote() {
        self.title = note.title
        self.text = note.text
        self.date = note.date
    }
    
    // функция сохранения измнений
    private func saveChanges() {
        if isNoteEmpty() {
            delete()
        } else {
            edit()
        }
        backgroundContext.saveContext()
    }
    
    // функция удаления заметки
    private func delete() {
        withAnimation {
            backgroundContext.delete(note)
            backgroundContext.saveContext()
        }
    }
    
    // функция редактирования заметки
    private func edit() {
        withAnimation {
            note.wrappedTitle = title
            note.wrappedText = text
            backgroundContext.saveContext()
        }
    }
}
