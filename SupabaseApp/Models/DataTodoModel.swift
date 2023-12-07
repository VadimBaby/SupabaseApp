//
//  DataTodoModel.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 07.12.2023.
//

import Foundation

struct DataTodoModel: Codable {
    let data: [TodoModel]
    let status: Int
    let statusText: String
}
