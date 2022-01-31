//
//  LoginViewModel.swift
//  Smart Client Fit
//
//  Created by Rafael Escaleira on 27/01/22.
//

import Foundation
import CoreLocation

class LoginViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
    
    private var webservice: Webservice
    
    @Published var users: [UserLogin] = []
    
    init() {
        self.webservice = Webservice()
        self.users = ((try? DataManager.shared.get(on: .users, [UserLogin].self)) ?? []).reversed()
    }
    
    func postLogin(completion: @escaping () -> ()) {
        if let secret = HeaderToken.defaultHeaderToken.pageProps?.session?.secret {
            self.webservice.postLogin(secret: secret, login: self.login, password: self.password) { loginResponse in
                if loginResponse?.isLogged == true {
                    self.webservice.getUser(secret: secret) { user in
                        if let user = user,
                           let userID = user.personal?.id,
                           let location = user.location?.name,
                           let plan = user.plan?.name,
                           let isActive = user.plan?.status == "active" ? true : false {
                            let userLogin = UserLogin(
                                login: self.login,
                                password: self.password,
                                name: user.presentedName,
                                userID: userID,
                                location: location,
                                plan: plan,
                                isActive: isActive
                            )
                            if self.users.isEmpty == true { self.users = [userLogin] }
                            else if self.users.contains(where: { $0.userID == user.personal?.id }) == false { self.users.append(userLogin) }
                            _ = try? self.users.save(on: .users)
                            completion()
                        }
                    }
                }
            }
        }
    }
}
