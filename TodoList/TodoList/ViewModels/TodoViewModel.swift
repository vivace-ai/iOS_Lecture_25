//
//  TodoViewModel.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/19/25.
//
import SwiftUI

@MainActor
final class TodoViewModel: ObservableObject {
    // MARK: - Properties
    
    // 정렬 옵션 열거형
    enum SortOption {
        case date       // 날짜순
        case completed  // 완료여부
        case title     // 제목순
    }
    
    // Published 프로퍼티
    @Published private(set) var todoItems: [TodoItem] = []
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .date
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // 캐시 프로퍼티
    private var filteredCache: [TodoItem]?
    private var lastSearchText: String?
    private var lastSortOption: SortOption?
    
    // MARK: - Initialization
    
    init() {
        loadTodos()
    }
    
    // MARK: - Public Methods
    
    // 필터링과 정렬이 적용된 할일 목록
    var filteredAndSortedTodos: [TodoItem] {
        // 캐시 확인
        if let cached = filteredCache,
           lastSearchText == searchText,
           lastSortOption == sortOption {
            return cached
        }
        
        // 검색어로 필터링
        let filtered = searchText.isEmpty ? todoItems : todoItems.filter { todo in
            todo.title.localizedCaseInsensitiveContains(searchText)
        }
        
        // 정렬 옵션 적용
        let sorted = filtered.sorted { first, second in
            switch sortOption {
            case .date:
                // 날짜 기준 정렬: 최신 날짜가 위로
                return first.date > second.date
                
            case .completed:
                // 완료 상태 기준 정렬
                if first.isCompleted != second.isCompleted {
                    // 미완료 항목이 위로, 완료 항목이 아래로
                    return !first.isCompleted && second.isCompleted
                }
                // 완료 상태가 같은 경우 날짜순 정렬
                if first.date == second.date {
                    // 날짜가 같으면 제목순
                    return first.title.localizedCompare(second.title) == .orderedAscending
                }
                return first.date > second.date
                
            case .title:
                // 제목 기준 정렬
                if first.title == second.title {
                    // 제목이 같으면 날짜순
                    return first.date > second.date
                }
                return first.title.localizedCompare(second.title) == .orderedAscending
            }
        }
        
        // 캐시 업데이트
        filteredCache = sorted
        lastSearchText = searchText
        lastSortOption = sortOption
        
        return sorted
    }
    
    // 할일 추가
    func addTodo(_ todo: TodoItem) {
        todoItems.append(todo)
        invalidateCache()
        
        do {
            try saveTodos()
        } catch {
            todoItems.removeLast()
            errorMessage = error.localizedDescription
        }
    }
    
    // 할일 완료/미완료 토글
    func toggleTodo(_ todo: TodoItem) {
        guard let index = todoItems.firstIndex(where: { $0.id == todo.id }) else { return }
        let previousState = todoItems[index].isCompleted
        todoItems[index].isCompleted.toggle()
        invalidateCache()
        
        do {
            try saveTodos()
        } catch {
            todoItems[index].isCompleted = previousState
            errorMessage = error.localizedDescription
        }
    }
    
    // 할일 삭제
    func deleteTodo(_ todo: TodoItem) {
        let removedItems = todoItems.filter { $0.id == todo.id }
        todoItems.removeAll { $0.id == todo.id }
        invalidateCache()
        
        do {
            try saveTodos()
        } catch {
            todoItems.append(contentsOf: removedItems)
            errorMessage = error.localizedDescription
        }
    }
    
    // 할일 수정
    func updateTodo(_ todo: TodoItem) {
        guard let index = todoItems.firstIndex(where: { $0.id == todo.id }) else { return }
        let previousTodo = todoItems[index]
        todoItems[index] = todo
        invalidateCache()
        
        do {
            try saveTodos()
        } catch {
            todoItems[index] = previousTodo
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Private Methods
    
    // UserDefaults에 할일 목록 저장
    private func saveTodos() throws {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encoded = try encoder.encode(todoItems)
            UserDefaults.standard.set(encoded, forKey: "todos")
        } catch {
            throw TodoError.saveError
        }
    }
    
    // UserDefaults에서 할일 목록 로드
    private func loadTodos() {
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let data = UserDefaults.standard.data(forKey: "todos") else {
                todoItems = []
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            todoItems = try decoder.decode([TodoItem].self, from: data)
            invalidateCache()
        } catch {
            todoItems = []
            errorMessage = TodoError.loadError.localizedDescription
        }
    }
    
    // 캐시 무효화
    private func invalidateCache() {
        filteredCache = nil
        lastSearchText = nil
        lastSortOption = nil
    }
    
    // 에러 메시지 초기화
    func clearError() {
        errorMessage = nil
    }
}

// MARK: - Preview Helper
#if DEBUG
extension TodoViewModel {
    static var preview: TodoViewModel {
        let viewModel = TodoViewModel()
        viewModel.todoItems = [
            TodoItem(title: "첫 번째 할일", isCompleted: false, date: Date()),
            TodoItem(title: "두 번째 할일", isCompleted: true, date: Date().addingTimeInterval(-86400)),
            TodoItem(title: "세 번째 할일", isCompleted: false, date: Date().addingTimeInterval(86400))
        ]
        return viewModel
    }
}
#endif
