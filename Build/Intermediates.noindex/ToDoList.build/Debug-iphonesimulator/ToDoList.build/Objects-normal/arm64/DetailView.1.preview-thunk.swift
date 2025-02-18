import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/vivace/Downloads/ToDoList-SwiftData-main/ToDoList/DetailView.swift", line: 1)
// File: DetailView.swift Project: ToDoList
// Created by: Prof. John Gallaugher on 9/5/24
// YouTube.com/profgallaugher  -  threads.net/john.gallaugher

import SwiftUI

struct DetailView: View {
    var passedValue: String // Don't initialize it - it will be passed from the parent view
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Image(systemName: __designTimeString("#2919_0", fallback: "swift"))
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text("You Are a Swifty Legend!\nAnd you passed over the value \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(__designTimeString("#2919_1", fallback: "Get Back!")) {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    DetailView(passedValue: __designTimeString("#2919_2", fallback: "Item 1"))
}
