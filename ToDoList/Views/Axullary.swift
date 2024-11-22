//
//  Axullary.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

// контекстное меню 
enum ContexMenuButtonType {
    case edit
    case share
    case delete
    
    func getTitle() -> String {
        switch self {
        case .edit:
           return "Редактировать"
        case .share:
            return "Поделиться"
        case .delete:
            return "Удалить"
        }
    }
    
    func getIcon() -> String {
        switch self {
        case .edit:
           return "edit"
        case .share:
            return "export"
        case .delete:
            return "trash"
        }
    }
}

struct ContexMenuButton: View {
    let type: ContexMenuButtonType
    let action: ()->Void
    
    var body: some View {
        Button(role: type == .delete ? .destructive : nil,
               action: action,
               label: { label })
    }
    
    var label: some View {
        HStack {
            Text(type.getTitle())
                .foregroundColor(type == .delete ? .red : .black)
            Spacer()
            Image(type.getIcon())
        }
    }
}
