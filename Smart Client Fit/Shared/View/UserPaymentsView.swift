//
//  UserPaymentView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import SwiftUI

struct UserPaymentView: View {
    
    var userPayment: UserPayment
    var isOpen: Bool
    
    var body: some View {
        GroupBox() {
            DisclosureGroup(isOpen ? "Pagamentos Pendentes" : "Pagamentos Realizados") {
                if isOpen {
                    ForEach(0 ..< (userPayment.openInstallments?.count ?? 0), id: \.self) { item in
                        Divider().padding(.vertical, 2)
                        
                        let open = userPayment.openInstallments?[item]
                        
                        HStack {
                            Group {
                                Image(systemName: "dollarsign.square.fill")
                                Text("R$ \(open?.value?.replacingOccurrences(of: ".", with: ",") ?? "")")
                            }
                            .foregroundColor(Color.orange)
                            .font(Font.system(.body).bold())
                            
                            Spacer(minLength: 25)
                            
                            Text("\(open?.dueDate?.formatted(on: "yyyy-MM-dd", with: "MMMM dd") ?? "")")
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                } else {
                    ForEach(0 ..< (userPayment.paidInstallments?.count ?? 0), id: \.self) { item in
                        Divider().padding(.vertical, 2)
                        
                        let paid = userPayment.paidInstallments?[item]
                        
                        HStack {
                            Group {
                                Image(systemName: "dollarsign.square.fill")
                                Text("R$ \(paid?.value?.replacingOccurrences(of: ".", with: ",") ?? "")")
                            }
                            .foregroundColor(Color.green)
                            .font(Font.system(.body).bold())
                            
                            Spacer(minLength: 25)
                            
                            Text("\(paid?.dueDate?.formatted(on: "yyyy-MM-dd", with: "MMMM dd") ?? "")")
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
            }.foregroundColor(.primary)
        }
    }
}
