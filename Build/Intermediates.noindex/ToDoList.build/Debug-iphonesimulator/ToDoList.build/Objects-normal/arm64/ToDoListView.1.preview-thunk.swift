import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/vivace/Downloads/ToDoList-SwiftData-main/ToDoList/ToDoListView.swift", line: 1)
// File: ToDoListView.swift Project: ToDoList
// Created by: Prof. John Gallaugher on 9/5/24
// YouTube.com/profgallaugher  -  threads.net/john.gallaugher

import SwiftUI

struct ToDoListView: View {
    var toDos = ["Learn Swift",
                 "Build Apps",
                 "Change the World",
                 "Bring the Awesome",
                 "Take a Vacation"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos, id: \.self) { toDo in
                    NavigationLink {
                        DetailView(passedValue: toDo)
                    } label: {
                        Text(toDo)
                    }
                }
            }
            .navigationTitle(__designTimeString("#2934_0", fallback: "To Do List"))
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
        }
    }
}

#Preview {
    ToDoListView()
}
