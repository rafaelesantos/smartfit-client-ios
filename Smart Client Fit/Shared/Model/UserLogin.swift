//
//  UserLogin.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 31/01/22.
//

import Foundation

struct UserLogin: Codable, Identifiable {
    var id = UUID()
    var login: String
    var password: String
    var name: String
    var userID: Int
    var location: String
    var plan: String
    var isActive: Bool
}
