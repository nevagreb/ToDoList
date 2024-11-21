//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

// структура - строка ToDo-листа
struct ToDoItemView: View {
    let note: ToDoNote
    let tapAction: ()->Void
    
    var body: some View {
        HStack(alignment: .top) {
            Image(note.isDone ? "checkmarkYellow" : "circle")
                .onTapGesture {
                    tapAction()
                }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(Font.system(size: 16))
                        .padding(.bottom, 6)
                        .strikethrough(note.isDone)
                    Text(note.text)
                        .font(Font.system(size: 12))
                        .lineLimit(2)
                        .padding(.bottom, 6)
                }
                .opacity(note.isDone ? 0.5 : 1)
                
                Text(note.date.formattedAsShortDate())
                    .font(Font.system(size: 12))
                    .opacity(0.5)
            }
            Spacer()
        }
        // используется для того, чтобы сделать всю
        // область HStack кликабельной
        .contentShape(Rectangle())
    }
}
