//
//  UserViewModel.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import Foundation

class UserViewModel: ObservableObject {
    private var webservice: Webservice
    
    @Published var history: UserHistoryAccess?
    @Published var payment: UserPayment?
    
    init() {
        self.webservice = Webservice()
    }
    
    func getUserHistoryAccess(user: User) {
        if let secret = HeaderToken.defaultHeaderToken.pageProps?.session?.secret,
           let userID = user.personal?.id {
            self.webservice.getUserHistoryAccess(secret: secret, userID: userID) { userHistoryAccess in
                if let userHistoryAccess = userHistoryAccess {
                    self.history = userHistoryAccess
                }
            }
        }
    }
    
    func getUserPayments() {
        if let secret = HeaderToken.defaultHeaderToken.pageProps?.session?.secret {
            self.webservice.getUserPayment(secret: secret) { userPayment in
                if let userPayment = userPayment {
                    self.payment = userPayment
                }
            }
        }
    }
}

