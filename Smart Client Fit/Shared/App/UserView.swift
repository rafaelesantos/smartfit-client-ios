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
    @State var isCardTapped: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                GroupBox(label: AboutAppLabelView(labelText: "Informações", labelImage: "person.text.rectangle.fill")) {
                    Divider().padding(.vertical, 4)
                    UserInfoView(user: user)
                }
                
                CardView(isCardTapped: self.$isCardTapped, card: Card(cardNumber: user.wallet?.masked_card_number ?? "", cardProviderLogo: user.wallet?.payment_company_name == "Mastercard" ? "mastercard-icon" : "visa-icon", cardCurrency: self.userViewModel.payment?.nextPayment?.value ?? "0", cardAmount: 1, linearColor1: Color("CardColor1"), linearColor2: Color("CardColor2"), shadow: Color("CardColor1")), date: self.userViewModel.payment?.nextPayment?.dueDate?.formatted(on: "yyyy-MM-dd", with: "MMMM, dd yyyy") ?? "")
                
                GroupBox(label: AboutAppLabelView(labelText: "Histórico", labelImage: "list.bullet.rectangle.fill")) {
                    Divider().padding(.vertical, 4)
                    if let userHistoryAccess = self.userViewModel.history {
                        UserHistoryAccessView(userHistoryAccess: userHistoryAccess)
                    }
                }
                
                GroupBox(label: AboutAppLabelView(labelText: "Pagamentos", labelImage: "creditcard.fill")) {
                    Divider().padding(.vertical, 4)
                    if let userPayment = self.userViewModel.payment {
                        HStack(alignment: .center, spacing: 15) {
                            Text("Total de pagamentos já realizados")
                            Text("R$ \(String(format: "%.2f", self.userViewModel.payment?.paidInstallments?.total ?? 0).replacingOccurrences(of: ".", with: ","))")
                                .foregroundColor(.green)
                                .bold()
                        }
                        UserPaymentView(userPayment: userPayment, isOpen: false)
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 15) {
                            Text("Total de pagamentos pendentes")
                            Text("R$ \(String(format: "%.2f", self.userViewModel.payment?.openInstallments?.total ?? 0).replacingOccurrences(of: ".", with: ","))")
                                .foregroundColor(.orange)
                                .bold()
                        }
                        UserPaymentView(userPayment: userPayment, isOpen: true)
                    }
                }
            }.padding(.all, 15)
        }.onAppear {
            self.userViewModel.getUserHistoryAccess(user: user)
            self.userViewModel.getUserPayments()
        }
    }
}
