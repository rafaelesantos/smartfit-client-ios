//
//  UserHistoryAccessView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import SwiftUI

struct UserHistoryAccessView: View {
    
    var userHistoryAccess: UserHistoryAccess
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Acessos dos Últimos 90 dias") {
                ForEach(0 ..< (userHistoryAccess.data?.count ?? 0), id: \.self) { item in
                    Divider().padding(.vertical, 2)
                    
                    HStack() {
                        Group {
                            Text((userHistoryAccess.data?[item].attributes?.createdAt ?? "").formatted(on: "yyyy-MM-dd-HH:mm", with: "HH:mm"))
                                .bold()
                                .font(.footnote)
                        }
                        
                        .frame(width: 50, height: 30, alignment: .center)
                        .background(Color.accentColor.opacity(0.2))
                        .cornerRadius(5)
                        
                        Spacer(minLength: 10)
                        
                        Text(((userHistoryAccess.data?[item].attributes?.createdAt ?? "").formatted(on: "yyyy-MM-dd-HH:mm", with: "EEEE, dd MMMM yyyy")))
                            .font(.footnote)
                    }
                }
            }.foregroundColor(.primary)
        }
    }
}
