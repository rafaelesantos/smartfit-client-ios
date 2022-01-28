//
//  UserInfoView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import SwiftUI

struct UserInfoView: View {
    
    var user: User
    
    var infos: [String] = [
        "Email",
        "Documento",
        "Contato",
        "Gênero",
        "Plano",
        "Valor do Plano"
    ]
    
    var infosImages: [String] = [
        "envelope.badge.fill",
        "person.text.rectangle.fill",
        "iphone",
        "figure.stand.line.dotted.figure.stand",
        "creditcard.fill",
        "dollarsign.square.fill"
    ]
    
    var userInfos: [String] {
        return [
            self.user.personal?.email ?? "Sem e-mail",
            self.user.personal?.personal_group?.document ?? "Sem documento",
            ((self.user.personal?.phone?.area ?? "") + (self.user.personal?.phone?.number ?? "")),
            self.user.personal?.personal_group?.gender ?? "Sem gênero",
            self.user.purchase?.plan?.name ?? "Sem plano",
            "R$ " + (self.user.purchase?.membership_price ?? "R$ ??,??").replacingOccurrences(of: ".", with: ",")
        ]
    }
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Informações do Usuário") {
                ForEach(0 ..< infos.count, id: \.self) { item in
                    Divider().padding(.vertical, 2)
                    
                    HStack {
                        Group {
                            Image(systemName: infosImages[item])
                            Text(infos[item])
                        }
                        .foregroundColor(Color.accentColor)
                        .font(Font.system(.body).bold())
                        
                        Spacer(minLength: 25)
                        
                        Text(userInfos[item])
                            .multilineTextAlignment(.trailing)
                    }
                }
            }.foregroundColor(.primary)
        }
    }
}
