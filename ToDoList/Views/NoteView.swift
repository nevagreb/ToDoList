//
//  NoteView.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

// структура - детальный экран заметки
struct NoteView: View {
    @Binding var note: NotesList.Note
    @EnvironmentObject var router: Router
    @EnvironmentObject var toDoList: ToDoList

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Название заметки", text: $note.title)
                .font(Font.system(size: 34, weight: .bold))
                .padding(.bottom, 8)
            Text(note.date.formattedAsShortDate())
                .font(Font.system(size: 12))
                .opacity(0.5)
                .padding(.bottom, 8)
            noteText
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onDisappear {
            if isNoteEmpty() {
                toDoList.deleteNote(with: note.id)
            }
        }
    }
    
    // текст эдитор для текста заметки с кастомным плэйсхолдером
    private var noteText: some View {
        ZStack (alignment: .topLeading) {
            if note.description.isEmpty {
                Text("Введите текст заметки")
                    .foregroundColor(Color(uiColor: .placeholderText))
            }
            TextEditor(text: $note._description ?? "")
                .opacity(note.description.isEmpty ? 0.1 : 1)
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
    
    private func isNoteEmpty() -> Bool {
        note.title.isEmpty //&& note.description?.isEmpty
    }
}

// используется для использования binding с optinal переменными
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
