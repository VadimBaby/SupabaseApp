//
//  SignInView.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 06.12.2023.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = FormViewModel()
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(CustomTextFieldStyle())
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(CustomTextFieldStyle())
            
            Button(action: {
                authViewModel.signInWithEmail(
                    email: viewModel.email,
                    password: viewModel.password
                )
            }) {
                if authViewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Sing In")
                }
            }
            .buttonStyle(CustomButtonStyle(disable: viewModel.disable || authViewModel.isLoading))
            .disabled(viewModel.disable || authViewModel.isLoading)
            
            NavigationLink("Register") {
                RegistrationView()
            }
            .foregroundStyle(Color.primary)
            .font(.title3)
            .fontWeight(.medium)
        }
        .padding()
        .navigationTitle("Sign In")
        .navigationBarBackButtonHidden()
        .onDisappear {
            viewModel.resetValues()
        }
    }
}

#Preview {
    NavigationStack {
        SignInView()
            .environmentObject(AuthViewModel())
    }
}
