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
                    
                    HStack {
                        Group {
                            Image(systemName: "person.crop.circle.badge.clock")
                        }
                        .foregroundColor(Color.accentColor)
                        .font(Font.system(.body).bold())
                        
                        Spacer(minLength: 25)
                        
                        Text(((userHistoryAccess.data?[item].attributes?.createdAt ?? "").formatted(on: "yyyy-MM-dd-HH:mm", with: "EEEE, dd MMMM yyyy // HH:mm")).replacingOccurrences(of: "//", with: "às"))
                            .multilineTextAlignment(.trailing)
                    }
                }
            }.foregroundColor(.primary)
        }
    }
}
