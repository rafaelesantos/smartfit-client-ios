//
//  Locations.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import Foundation

struct Locations:  Codable {
    let data: Data?
    let success: Bool?
    
    struct Data: Codable {
        let data: [DataAttributes]?
        
        struct DataAttributes: Codable {
            let id: String?
            let type: String?
            let attributes: Attributes?
            
            struct Attributes: Codable {
                let name: String?
                let address: String?
                let region: String?
                let cityName: String?
                let stateName: String?
                let uf: String?
                
                enum CodingKeys: String, CodingKey {
                    case name = "name"
                    case address = "address"
                    case region = "region"
                    case cityName = "city-name"
                    case stateName = "state-name"
                    case uf = "uf"
                }
            }
        }
    }
    
    func save(on reference: DataManager.Reference) throws -> Self {
        let defaultEncoded = try self.encoded
        try DataManager.shared.defaults.set(defaultEncoded, forKey: reference.value)
        try DataManager.shared.defaults.synchronize()
        return self
    }
}
