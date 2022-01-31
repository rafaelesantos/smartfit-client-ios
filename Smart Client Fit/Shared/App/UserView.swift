//
//  UserView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import SwiftUI

struct UserView: View {
    @ObservedObject private var userViewModel = UserViewModel()
    @State private var isPresented = false
    @State var isCardTapped: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                if let user = self.userViewModel.user {
                    GroupBox(label: AboutAppLabelView(labelText: "Informações", labelImage: "person.text.rectangle.fill")) {
                        Divider().padding(.vertical, 4)
                        UserInfoView(user: user)
                    }
                    
                    GroupBox(label: AboutAppLabelView(labelText: "Histórico", labelImage: "list.bullet.rectangle.fill")) {
                        if let userHistoryAccess = self.userViewModel.history,
                           let locationsDataAttributes = self.userViewModel.locations?.data?.data,
                           self.userViewModel.mapLocations.isEmpty == false,
                           (try? DataManager.shared.get(on: .currentLocation, MapLocation.self)) != nil {
                            Divider().padding(.vertical, 4)
                            MapView(locations: self.userViewModel.mapLocations)
                                .frame(height: 256)
                                .cornerRadius(12)
                                .padding(.bottom, 10)
                            UserHistoryAccessView(userHistoryAccess: userHistoryAccess, locations: locationsDataAttributes)
                        } else {
                            VStack {
                                ProgressView()
                            }
                        }
                    }
                    
                    
                    GroupBox(label: AboutAppLabelView(labelText: "Pagamentos", labelImage: "creditcard.fill")) {
                        Divider().padding(.vertical, 4)
                        
                        CardView(isCardTapped: self.$isCardTapped, card: Card(cardNumber: user.wallet?.masked_card_number ?? "", cardProviderLogo: user.wallet?.payment_company_name == "Mastercard" ? "mastercard-icon" : "visa-icon", cardCurrency: self.userViewModel.payment?.nextPayment?.value ?? "0", cardAmount: 1, linearColor1: Color("CardColor1"), linearColor2: Color("CardColor2"), shadow: Color("CardColor1")), date: self.userViewModel.payment?.nextPayment?.dueDate?.formatted(on: "yyyy-MM-dd", with: "MMMM, dd yyyy") ?? "")
                            .frame(height: isCardTapped ? 230 : (230 * 1.65))
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                        
                        if isCardTapped {
                            
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
                            } else {
                                VStack {
                                    ProgressView()
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                        ProgressView()
                    }
                    
                }
            }.padding(.all, 15)
        }
        .onAppear {
            self.userViewModel.getUser()
        }
        .onDisappear {
            try? DataManager.shared.remove(on: .currentUser)
            try? DataManager.shared.remove(on: .currentLocation)
            
            if let user = self.userViewModel.user,
               let userID = user.personal?.id {
                try? DataManager.shared.remove(on: .userHistoryAccess(userID))
                try? DataManager.shared.remove(on: .userPayment(userID))
            }
        }
    }
}
