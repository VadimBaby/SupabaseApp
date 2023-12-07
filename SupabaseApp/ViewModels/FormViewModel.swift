//
//  FormViewModel.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 06.12.2023.
//

import Foundation
import Combine

final class FormViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var disable: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $email
            .combineLatest($password)
            .sink { email, password in
                guard email.isValidEmail(), password.count > 7 else {
                    self.disable = true
                    return
                }
                
                self.disable = false
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach{ $0.cancel() }
    }
    
    func resetValues() {
        email = ""
        password = ""
        disable = true
    }
}
