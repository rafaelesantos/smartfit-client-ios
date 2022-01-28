//
//  LoginViewModel.swift
//  Smart Client Fit
//
//  Created by Rafael Escaleira on 27/01/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
    
    private var webservice: Webservice
    
    @Published var users: [User] = []
    
    init() {
        self.webservice = Webservice()
    }
    
    func postLogin(completion: @escaping () -> ()) {
        if let secret = HeaderToken.defaultHeaderToken.pageProps?.session?.secret {
            self.webservice.postLogin(secret: secret, login: self.login, password: self.password) { loginResponse in
                if loginResponse?.isLogged == true {
                    self.webservice.getUser(secret: secret) { user in
                        if let user = user {
                            if self.users.isEmpty == true { self.users = [user] }
                            else if self.users.contains(where: {
                                $0.personal?.id == user.personal?.id &&
                                $0.personal?.id != nil &&
                                user.personal?.id != nil
                            }) { self.users.append(user) }
                            completion()
                        }
                    }
                }
            }
        }
    }
}