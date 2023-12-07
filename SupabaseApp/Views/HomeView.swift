//
//  HomeView.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 06.12.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = TodosViewModel()
    
    @State private var showSheet: Bool = false
    
    @State private var isFetching: Bool = false
    
    var body: some View {
        ZStack {
            if isFetching {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.todos.sorted{$0.timestamp > $1.timestamp}) { todo in
                        getTodoView(todo: todo)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.showSheet = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .sheet(isPresented: $showSheet, content: {
            CreateTodoSheet(viewModel: viewModel)
        })
        .refreshable {
            await viewModel.fetchTodos()
        }
        .task {
            if viewModel.todos.isEmpty {
                await MainActor.run {
                    self.isFetching = true
                }
                await viewModel.fetchTodos()
                await MainActor.run {
                    self.isFetching = false
                }
            }
        }
    }
    
    @ViewBuilder private func getTodoView(todo: TodoModel) -> some View {
        HStack {
            Text(todo.title)
            Spacer()
            Rectangle()
                .stroke(lineWidth: 2)
                .frame(width: 30, height: 30)
                .overlay {
                    if todo.done {
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.green)
                    }
                }
                .onTapGesture {
                    viewModel.updateDoneTodo(id: todo.id)
                }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
        .environmentObject(AuthViewModel())
}
