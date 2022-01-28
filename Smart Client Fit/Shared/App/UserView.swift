//
//  UserView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import SwiftUI

struct UserView: View {
    var user: User
    @ObservedObject private var userViewModel = UserViewModel()
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    
                    GroupBox(label: AboutAppLabelView(labelText: "Informações", labelImage: "person.text.rectangle.fill")) {
                        Divider().padding(.vertical, 4)
                        UserInfoView(user: user)
                    }
                    
                    GroupBox(label: AboutAppLabelView(labelText: "Histórico", labelImage: "list.bullet.rectangle.fill")) {
                        Divider().padding(.vertical, 4)
                        if let userHistoryAccess = self.userViewModel.history {
                            UserHistoryAccessView(userHistoryAccess: userHistoryAccess)
                        }
                    }
                    
                    GroupBox(label: AboutAppLabelView(labelText: "Pagamentos", labelImage: "creditcard.fill")) {
                        Divider().padding(.vertical, 4)
                        if let userPayment = self.userViewModel.payment {
                            UserPaymentView(userPayment: userPayment, isOpen: false)
                            UserPaymentView(userPayment: userPayment, isOpen: true)
                        }
                    }
                }.padding(.all, 15)
            }
            .navigationBarTitle(Text(user.presentedName), displayMode: .large)
        }.onAppear {
            self.userViewModel.getUserHistoryAccess(user: user)
            self.userViewModel.getUserPayments()
        }
    }
}
