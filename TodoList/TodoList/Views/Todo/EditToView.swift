
//
//  Untitled.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/19/25.
//

import SwiftUI

struct EditTodoView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: TodoViewModel
    
    let todoItem: TodoItem
    
    @State private var title: String
    @State private var date: Date
    @State private var isCompleted: Bool
    @FocusState private var isTitleFocused: Bool
    
    // MARK: - Constants
    private enum Constants {
        static let spacing: CGFloat = 24
        static let innerSpacing: CGFloat = 8
        static let cornerRadius: CGFloat = 12
        static let shadowRadius: CGFloat = 5
        static let shadowOpacity: Double = 0.1
        
        static let backgroundColor: Color = .gray.opacity(0.1)
        
        enum Text {
            static let title = "할일 수정"
            static let cancel = "취소"
            static let save = "저장"
            static let todoLabel = "할일"
            static let todoPlaceholder = "할일을 입력하세요"
            static let dateLabel = "날짜"
            static let completedLabel = "완료 여부"
        }
        
        enum Animation {
            static let spring = SwiftUI.Animation.spring(
                response: 0.3,
                dampingFraction: 0.7,
                blendDuration: 0
            )
        }
    }
    
    // MARK: - Initialization
    init(viewModel: TodoViewModel, todoItem: TodoItem) {
        self.viewModel = viewModel
        self.todoItem = todoItem
        _title = State(initialValue: todoItem.title)
        _date = State(initialValue: todoItem.date)
        _isCompleted = State(initialValue: todoItem.isCompleted)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                backgroundLayer
                
                ScrollView {
                    VStack(spacing: Constants.spacing) {
                        todoInputSection
                        datePickerSection
                        completionToggleSection
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle(Constants.Text.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                leadingToolbarItem
                trailingToolbarItem
            }
            .onAppear {
                isTitleFocused = true
            }
        }
    }
    
    // MARK: - View Components
    private var backgroundLayer: some View {
        (colorScheme == .dark ? Color.black : Constants.backgroundColor)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var todoInputSection: some View {
        VStack(alignment: .leading, spacing: Constants.innerSpacing) {
            Text(Constants.Text.todoLabel)
                .font(.headline)
                .foregroundColor(.gray)
            
            TextField(Constants.Text.todoPlaceholder, text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isTitleFocused)
                .submitLabel(.done)
                .onSubmit {
                    if isValidInput() {
                        saveTodo()
                    }
                }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(Constants.Text.todoLabel): \(title)")
    }
    
    private var datePickerSection: some View {
        VStack(alignment: .leading, spacing: Constants.innerSpacing) {
            Text(Constants.Text.dateLabel)
                .font(.headline)
                .foregroundColor(.gray)
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .background(datePickerBackground)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(Constants.Text.dateLabel): \(formattedDate)")
    }
    
    private var completionToggleSection: some View {
        VStack(alignment: .leading, spacing: Constants.innerSpacing) {
            Toggle(Constants.Text.completedLabel, isOn: $isCompleted)
                .tint(.blue)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(Constants.Text.completedLabel): \(isCompleted ? "완료" : "미완료")")
    }
    
    private var datePickerBackground: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(colorScheme == .dark ? Color.black : .white)
            .shadow(
                color: Color.black.opacity(Constants.shadowOpacity),
                radius: Constants.shadowRadius
            )
    }
    
    private var leadingToolbarItem: ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(Constants.Text.cancel) {
                dismiss()
            }
        }
    }
    
    private var trailingToolbarItem: ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(Constants.Text.save) {
                saveTodo()
            }
            .disabled(!isValidInput())
        }
    }
    
    // MARK: - Helper Methods
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func isValidInput() -> Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Actions
    private func saveTodo() {
        let updatedTodo = TodoItem(
            id: todoItem.id,
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            isCompleted: isCompleted,
            date: date
        )
        
        withAnimation(Constants.Animation.spring) {
            viewModel.updateTodo(updatedTodo)
        }
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    EditTodoView(
        viewModel: TodoViewModel(),
        todoItem: TodoItem(
            title: "테스트 할일",
            isCompleted: false,
            date: Date()
        )
    )
}
