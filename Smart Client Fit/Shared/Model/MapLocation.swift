//
//  MapLocation.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 30/01/22.
//

import Foundation

struct MapLocation: Codable, Identifiable {
    let id: UUID = UUID()
    var hour: String
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    
    func save(on reference: DataManager.Reference) throws -> Self {
        let defaultEncoded = try self.encoded
        try DataManager.shared.defaults.set(defaultEncoded, forKey: reference.value)
        try DataManager.shared.defaults.synchronize()
        return self
    }
}
