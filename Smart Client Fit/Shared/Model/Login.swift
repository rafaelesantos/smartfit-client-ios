//
//  Login.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import Foundation

struct Login: Codable {
    let status: String?
    let isLogged: Bool?
    
    func save(on reference: DataManager.Reference) throws -> Self {
        let defaultEncoded = try self.encoded
        try DataManager.shared.defaults.set(defaultEncoded, forKey: reference.value)
        try DataManager.shared.defaults.synchronize()
        return self
    }
}
