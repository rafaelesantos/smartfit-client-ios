//
//  UserRowView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import SwiftUI

struct UserRowView: View {
    // MARK: - PROPERTIES
    
    var user: User?
    
    // MARK: - BODY
    
    var body: some View {
        if let name = user?.personal?.name,
           let email = user?.personal?.email,
           let plan = user?.plan?.name {
            VStack(alignment: .center, spacing: 10) {
                HStack(alignment: .center, spacing: 15) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                    HStack(alignment: .center, spacing: 25) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(name)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Email: \(email)\nPlano Vigente: \(plan)")
                                .font(.footnote)
                                .foregroundColor(Color.secondary)
                                .multilineTextAlignment(.leading)
                        }
                        //Image(systemName: user?.purchase?.plan?.name == "Black" ? "crown.fill" : "bandage.fill")
                    }
                }
            }
        }
    }
}
