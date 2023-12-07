//
//  SupabaseAppApp.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 06.12.2023.
//

import SwiftUI

@main
struct SupabaseAppApp: App {
    
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if authViewModel.isLoading {
                    ProgressView()
                } else {
                    if authViewModel.user == nil {
                        NavigationStack {
                            SignInView()
                        }
                    } else {
                        TabBarView()
                    }
                }
            }
            .environmentObject(authViewModel)
            .task {
                await authViewModel.getCurrentSession()
            }
        }
    }
}
