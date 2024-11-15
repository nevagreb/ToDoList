//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

// структура - строка ToDo-листа
struct ToDoItemView: View {
    let note: NotesList.Note
    let tapAction: ()->Void
    
    var body: some View {
        HStack(alignment: .top) {
            Image(note.isSelected ? "checkmarkYellow" : "circle")
                .onTapGesture {
                    tapAction()
                }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(Font.system(size: 16))
                        .padding(.bottom, 6)
                        .strikethrough(note.isSelected)
                    Text(note.description)
                        .font(Font.system(size: 12))
                        .lineLimit(2)
                        .padding(.bottom, 6)
                }
                .opacity(note.isSelected ? 0.5 : 1)
                
                Text(note.date.formattedAsShortDate())
                    .font(Font.system(size: 12))
                    .opacity(0.5)
            }
        }
    }
}

//#Preview {
//    ToDoItemView(note: Note())
//        .preferredColorScheme(.dark)
//}
