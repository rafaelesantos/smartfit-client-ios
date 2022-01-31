//
//  UserRowView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import SwiftUI

struct UserRowView: View {
    // MARK: - PROPERTIES
    
    var user: UserLogin?
    
    // MARK: - BODY
    
    var body: some View {
        if let name = user?.name,
           let login = user?.login,
           let location = user?.location,
           let plan = user?.plan,
           let isActive = user?.isActive {
            VStack(alignment: .center, spacing: 10) {
                HStack(alignment: .center, spacing: 15) {
                    HStack(alignment: .center, spacing: 25) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(name)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Spacer()
                                if isActive == false {
                                    Image(systemName: "creditcard.trianglebadge.exclamationmark")
                                        .foregroundColor(.red)
                                } else if plan.lowercased() == "black" {
                                    Image(systemName: "crown.fill")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            
                            Divider().padding(.vertical, 4)
                            VStack {
                                HStack {
                                    Text("Login ")
                                        .font(.footnote)
                                        .foregroundColor(.accentColor)
                                        .bold()
                                    Spacer()
                                    Text(Veil(pattern: "###.###.###-##").mask(input: login))
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                                HStack {
                                    Text("Unidade ")
                                        .font(.footnote)
                                        .foregroundColor(.accentColor)
                                        .bold()
                                    Spacer()
                                    Text(location)
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
