//
//  AboutAppLabelView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import SwiftUI

struct AboutAppLabelView: View {
    // MARK: - PROPERTIES
    
    var labelText: String
    var labelImage: String
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
                .tint(.accentColor)
                .foregroundColor(.accentColor)
        }
    }
}

struct AboutAppLabelView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppLabelView(labelText: "Sobre o app", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
