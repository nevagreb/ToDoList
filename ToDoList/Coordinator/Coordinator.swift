//
//  Router.swift
//  ToDoList
//
//  Created by Kristina Grebneva on 15.11.2024.
//

import SwiftUI

// класс используется для навигации 
final class Coordinator: ObservableObject {
    @Published var path = NavigationPath() 
    
    func navigate<T: Hashable>(to route: T) {
        path.append(route)
    }

    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
