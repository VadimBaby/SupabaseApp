//
//  CustomButtonStyle.swift
//  SupabaseApp
//
//  Created by Вадим Мартыненко on 06.12.2023.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    let disable: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background{
                disable ? Color.gray : configuration.isPressed ? Color.blue.opacity(0.7 ):  Color.blue
            }
            .clipShape(.rect(cornerRadius: 15))
    }
}

#Preview {
    Button("Custom Button") {
        
    }
    .buttonStyle(CustomButtonStyle(disable: true))
    .padding()
}
