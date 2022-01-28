//
//  TextFieldRowView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import SwiftUI

struct TextFieldRowView: View {
    // MARK: - PROPERTIES
    
    var name: String
    var textContentType: UITextContentType
    var value: Binding<String>
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            HStack {
                Text(name).foregroundColor(Color.gray)
                Spacer()
                Spacer()
                if textContentType == .password {
                    SecureField("Informe \(name)", text: value)
                        .textContentType(textContentType)
                        .multilineTextAlignment(.trailing)
                } else {
                    TextField("Informe \(name)", text: value)
                        .textContentType(textContentType)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}
