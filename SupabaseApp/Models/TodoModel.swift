//
//  TodoModel.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 07.12.2023.
//

import Foundation

struct TodoModel: Identifiable, Codable {
    let id: Int
    let title: String
    var done: Bool
    var timestamp: Date = Date()
}
