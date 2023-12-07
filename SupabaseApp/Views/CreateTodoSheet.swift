//
//  CreateTodoSheet.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 07.12.2023.
//

import SwiftUI

struct CreateTodoSheet: View {
    
    @ObservedObject var viewModel: TodosViewModel
    
    @State private var title: String = ""
    
    @State private var isLoading: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    @State private var task: Task<Void, Never>? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Todo", text: $title)
                .textFieldStyle(CustomTextFieldStyle())
            
            Button(action: {
                task = Task {
                    self.isLoading = true
                    await viewModel.createTodo(title: title)
                    dismiss()
                }
            }) {
                if isLoading {
                    ProgressView()
                        .tint(Color.white)
                } else {
                    Text("Create")
                }
            }
            .buttonStyle(CustomButtonStyle(disable: title.isEmpty || isLoading))
        }
        .padding()
        .onDisappear {
            task?.cancel()
        }
    }
}

#Preview {
    CreateTodoSheet(viewModel: TodosViewModel())
}
