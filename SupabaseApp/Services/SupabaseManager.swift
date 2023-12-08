//
//  AuthManager.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 06.12.2023.
//

import Foundation
import Supabase

actor SupabaseManager {
    static let shared = SupabaseManager()
    
    private init() {}
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://tmkstxpobccffciquyej.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRta3N0eHBvYmNjZmZjaXF1eWVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE4NTI5NjgsImV4cCI6MjAxNzQyODk2OH0.H-jkyVt7BPykxRMJMu6blyixnkYkPf5prTDOtkXpGjc")
    
    func getCurrentSession() async throws -> UserModel {
        let session = try await client.auth.session
        print(session)
        return UserModel(id: session.user.id.uuidString, email: session.user.email)
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> UserModel {
        let registrationAuthResponse = try await client.auth.signUp(email: email, password: password)
        guard let session = registrationAuthResponse.session else {
            throw URLError(.badServerResponse)
        }
        
        return UserModel(id: session.user.id.uuidString, email: session.user.email)
    }
    
    func signInWithEmail(email: String, password: String) async throws -> UserModel {
        let session = try await client.auth.signIn(email: email, password: password)
        return UserModel(id: session.user.id.uuidString, email: session.user.email)
    }
    
    func fetchTodos() async throws -> [TodoModel] {
        let todos: [TodoModel] = try await client.database.from("todos").select().execute().value
        
        return todos
    }
    
    func createTodo(todo: TodoModel) async throws {
        let response = try await client.database.from("todos").insert(todo).execute()
        
        if response.status != 201 {
            throw URLError(.badServerResponse)
        }
    }
    
    func updateDoneTodo(id: Int, done: Bool) async throws {
        try await client.database.from("todos").update(["done": done.description]).eq("id", value: id).execute()
    }
    
    func deleteTodo(id: Int) async throws {
        try await client.database.from("todos").delete().eq("id", value: id).execute()
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
}
