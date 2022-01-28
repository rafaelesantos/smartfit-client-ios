//
//  HeaderToken.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import Foundation

struct HeaderToken: Codable {
    let pageProps: PageProps?
    let __N_SSP: Bool?
    
    struct PageProps: Codable {
        let session: Session?
        
        struct Session: Codable {
            let isLoggedIn: Bool?
            let token: String?
            let secret: String?
        }
    }
    
    static var defaultHeaderToken: HeaderToken {
        return HeaderToken(
            pageProps: PageProps(
                session: PageProps.Session(
                    isLoggedIn: nil,
                    token: nil,
                    secret: "2fdf734f-8ffd-4657-9a67-ce0dea3249ff"
                )
            ),
            __N_SSP: nil
        )
    }
    
    func save(on reference: DataManager.Reference) throws -> Self {
        let defaultEncoded = try self.encoded
        try DataManager.shared.defaults.set(defaultEncoded, forKey: reference.value)
        try DataManager.shared.defaults.synchronize()
        return self
    }
}
