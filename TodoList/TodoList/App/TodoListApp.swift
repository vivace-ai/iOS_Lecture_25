//
//  TodoListApp.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/19/25.
//

import SwiftUI


@main
struct TodoListApp: App {
    @StateObject private var viewModel = TodoViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainTodoListView()    // ContentView() 대신 MainTodoListView() 사용
                           .environmentObject(viewModel)
        }
    }
}
