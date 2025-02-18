//
//  ToDoRowView.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/19/25.
//


import SwiftUI

struct TodoRowView: View {
    // MARK: - Properties
    let todo: TodoItem
    @ObservedObject var viewModel: TodoViewModel
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Constants
    private enum Constants {
        static let spacing: CGFloat = 16
        static let checkboxSize: CGFloat = 24
        static let checkmarkSize: CGFloat = 12
        static let cornerRadius: CGFloat = 16
        static let titleFontSize: CGFloat = 16
        static let dateFontSize: CGFloat = 12
        
        static let springAnimation = Animation.spring(
            response: 0.3,
            dampingFraction: 0.6,
            blendDuration: 0
        )
    }
    
    // MARK: - Computed Properties
    private var dateText: String {
        DateFormatter.todoDateFormatter.string(from: todo.date)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ?
            Color.black.opacity(0.3) :
            Color.white
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: Constants.spacing) {
            checkboxButton
            todoContent
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(backgroundColor)
                .shadow(
                    color: Color.black.opacity(0.05),
                    radius: 8,
                    x: 0,
                    y: 2
                )
        )
        .contextMenu {
            deleteButton
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityAddTraits(todo.isCompleted ? .isSelected : [])
    }
    
    // MARK: - Subviews
    private var checkboxButton: some View {
        Button(action: toggleTodo) {
            ZStack {
                Circle()
                    .stroke(
                        todo.isCompleted ? Color.blue : Color.gray.opacity(0.5),
                        lineWidth: 2
                    )
                    .frame(
                        width: Constants.checkboxSize,
                        height: Constants.checkboxSize
                    )
                
                if todo.isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(
                            size: Constants.checkmarkSize,
                            weight: .bold
                        ))
                        .foregroundColor(.blue)
                }
            }
        }
        .accessibilityLabel(todo.isCompleted ? "완료 취소하기" : "완료하기")
    }
    
    private var todoContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(todo.title)
                .font(.system(
                    size: Constants.titleFontSize,
                    weight: .medium
                ))
                .strikethrough(todo.isCompleted)
                .foregroundColor(todo.isCompleted ? .gray : .primary)
            
            Text(dateText)
                .font(.system(size: Constants.dateFontSize))
                .foregroundColor(.gray)
        }
    }
    
    private var deleteButton: some View {
        Button(role: .destructive) {
            withAnimation {
                viewModel.deleteTodo(todo)
            }
        } label: {
            Label("삭제", systemImage: "trash")
        }
    }
    
    // MARK: - Actions
    private func toggleTodo() {
        withAnimation(Constants.springAnimation) {
            viewModel.toggleTodo(todo)
        }
    }
    
    // MARK: - Accessibility
    private var accessibilityLabel: String {
        let status = todo.isCompleted ? "완료됨" : "미완료"
        return "\(todo.title), \(dateText), \(status)"
    }
}

// MARK: - DateFormatter Extension
private extension DateFormatter {
    static let todoDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }()
}

// MARK: - Preview
#Preview {
    TodoRowView(
        todo: TodoItem(
            title: "테스트 할일",
            isCompleted: false,
            date: Date()
        ),
        viewModel: TodoViewModel()
    )
    .padding()
}
