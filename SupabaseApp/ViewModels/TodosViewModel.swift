//
//  TodosViewModel.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 07.12.2023.
//

import Foundation

final class TodosViewModel: ObservableObject {
    @Published private(set) var todos: [TodoModel] = [] 
    
    private var tasks: [Task<Void, Never>] = []
    
    private let service = SupabaseManager.shared
    
    func fetchTodos() async {
        do {
            let todos = try await service.fetchTodos()
            
            await MainActor.run {
                self.todos = todos
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createTodo(title: String) async {
        do {
            let todo = TodoModel(id: .random(in: 0...99999999999), title: title, done: false)
            
            try await service.createTodo(todo: todo)
            
            await MainActor.run {
                self.todos.append(todo)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateDoneTodo(id: Int) {
        guard let index = todos.firstIndex(where: {$0.id == id}) else { return }
        
        todos[index].done.toggle()
        
        let done = todos[index].done
        
        Task {
            do {
                try await service.updateDoneTodo(id: id, done: done)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func cancelAllTasks() {
        tasks.forEach{ $0.cancel() }
        
        tasks = []
    }
}
