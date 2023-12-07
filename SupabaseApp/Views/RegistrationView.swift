//
//  RegistrationView.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 06.12.2023.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = FormViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(CustomTextFieldStyle())
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(CustomTextFieldStyle())
            
            Button(action: {
                authViewModel.signUpNewUserWithEmail(
                    email: viewModel.email,
                    password: viewModel.password
                )
            }) {
                if authViewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Register")
                }
            }
            .buttonStyle(CustomButtonStyle(disable: viewModel.disable || authViewModel.isLoading))
            .disabled(viewModel.disable || authViewModel.isLoading)
            
            Button("Go Back") { dismiss() }
                .foregroundStyle(Color.primary)
                .font(.title3)
                .fontWeight(.medium)
        }
        .padding()
        .navigationTitle("Registration")
        .navigationBarBackButtonHidden()
        .onDisappear {
            viewModel.resetValues()
        }
    }
}

#Preview {
    NavigationStack {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
