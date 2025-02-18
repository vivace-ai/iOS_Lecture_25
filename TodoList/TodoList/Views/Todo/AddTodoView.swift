//
//  AddTodoView.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/19/25.
//
import SwiftUI

struct AddTodoView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: TodoViewModel
    
    @State private var title = ""
    @State private var date = Date()
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
            static let title = "새 작업"
            static let cancel = "취소"
            static let add = "추가"
            static let todoLabel = "할일"
            static let todoPlaceholder = "할일을 입력하세요"
            static let dateLabel = "날짜"
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                backgroundLayer
                
                VStack(spacing: Constants.spacing) {
                    todoInputSection
                    datePickerSection
                    Spacer()
                }
                .padding()
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
                    if !title.isEmpty {
                        addTodo()
                    }
                }
        }
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
            Button {
                addTodo()
            } label: {
                Text(Constants.Text.add)
                    .bold()
            }
            .disabled(title.isEmpty)
        }
    }
    
    // MARK: - Actions
    private func addTodo() {
        let todo = TodoItem(title: title, isCompleted: false, date: date)
        withAnimation {
            viewModel.addTodo(todo)
        }
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    AddTodoView(viewModel: TodoViewModel())
}

// MARK: - Accessibility Extension
extension AddTodoView {
    private var accessibilityAddButton: some View {
        Button(action: addTodo) {
            Text(Constants.Text.add)
                .bold()
        }
        .disabled(title.isEmpty)
        .accessibilityLabel("할일 추가하기")
        .accessibilityHint("입력한 할일을 목록에 추가합니다")
    }
}
