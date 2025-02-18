//
//  Untitled.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/21/25.
//
import SwiftUI

struct MainTodoListView: View {
    // MARK: - Properties
    @StateObject private var viewModel = TodoViewModel()
    @State private var showingAddTodo = false
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            mainContent
        }
        .sheet(isPresented: $showingAddTodo) {
            AddTodoView(viewModel: viewModel)
        }
    }
    
    // MARK: - Subviews
    private var mainContent: some View {
        ZStack {
            AppConstants.Colors.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                sortingPickerView
                todoListView
            }
            .navigationTitle("✅ 오늘의 할일")  // 체크마크
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                addButton
            }
            .searchable(
                text: $viewModel.searchText,
                prompt: "할일 검색"
            )
        }
    }
    
    private var sortingPickerView: some View {
        Picker("정렬", selection: $viewModel.sortOption) {
            sortingOptions
        }
        .pickerStyle(.segmented)
        .padding()
        .background(pickerBackground)
        .padding(.horizontal)
    }
    
    private var sortingOptions: some View {
        Group {
            Text("날짜")
                .tag(TodoViewModel.SortOption.date)
            Text("완료")
                .tag(TodoViewModel.SortOption.completed)
            Text("제목")
                .tag(TodoViewModel.SortOption.title)
        }
    }
    
    private var pickerBackground: some View {
        RoundedRectangle(cornerRadius: AppConstants.Layout.cornerRadius)
            .fill(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
            .shadow(
                color: Color.black.opacity(AppConstants.Layout.shadowOpacity),
                radius: AppConstants.Layout.shadowRadius,
                x: 0,
                y: 2
            )
    }
    
    private var todoListView: some View {
        List {
            if viewModel.filteredAndSortedTodos.isEmpty && !viewModel.searchText.isEmpty {
                EmptySearchView(searchText: viewModel.searchText)
                    .listRowBackground(Color.clear)
            } else {
                todoItems
            }
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
    
    private var todoItems: some View {
        ForEach(viewModel.filteredAndSortedTodos) { todo in
            TodoRowView(todo: todo, viewModel: viewModel)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    deleteButton(for: todo)
                }
        }
    }
    
    private func deleteButton(for todo: TodoItem) -> some View {
        Button(role: .destructive) {
            withAnimation {
                viewModel.deleteTodo(todo)
            }
        } label: {
            Label("삭제", systemImage: "trash")
        }
        .tint(AppConstants.Colors.accentColor)
    }
    
    private var addButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                showingAddTodo = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            }
            .tint(AppConstants.Colors.accentColor)
        }
    }
}

// MARK: - Preview Provider
#Preview {
    MainTodoListView()
        .environmentObject(TodoViewModel.preview)
}
