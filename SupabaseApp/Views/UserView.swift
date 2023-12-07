//
//  UserView.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 07.12.2023.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            if let user = authViewModel.user {
                VStack {
                    Text("id: \(user.id), email: \(user.email ?? "No Email")")
                    
                    Button("Sign Out") {
                        authViewModel.signOut()
                    }
                    .buttonStyle(CustomButtonStyle(disable: false))
                }
                .padding()
            } else {
                Text("error")
            }
        }
    }
}

#Preview {
    UserView()
        .environmentObject(AuthViewModel())
}
