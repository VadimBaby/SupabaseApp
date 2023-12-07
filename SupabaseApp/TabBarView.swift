//
//  TabBarView.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 07.12.2023.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selection: Int = 1
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                HomeView()
            }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(1)
            
            UserView()
                .tabItem {
                    Image(systemName: "person")
                    Text("User")
                }
                .tag(2)
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(AuthViewModel())
}
