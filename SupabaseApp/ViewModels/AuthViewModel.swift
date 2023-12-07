//
//  AuthViewModel.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 06.12.2023.
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    @Published var user: UserModel? = nil
    @Published var isLoading: Bool = false
    
    private let service = SupabaseManager.shared
    
    func getCurrentSession() async {
        await makeRequest {
            return try await service.getCurrentSession()
        }
    }
    
    func signUpNewUserWithEmail(email: String, password: String) {
        Task {
            await makeRequest {
                return try await service.signUpWithEmail(email: email, password: password)
            }
        }
    }
    
    func signInWithEmail(email: String, password: String) {
        Task {
            await makeRequest {
                return try await service.signInWithEmail(email: email, password: password)
            }
        }
    }
    
    func signOut() {
        Task {
            do {
                try await service.signOut()
                
                await MainActor.run {
                    self.user = nil
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    private func makeRequest(request: () async throws -> UserModel) async {
        await MainActor.run {
            self.isLoading = true
        }
        
        do {
            let user = try await request()
            
            await MainActor.run {
                self.user = user
                self.isLoading = false
            }
        } catch {
            print(error)
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}
