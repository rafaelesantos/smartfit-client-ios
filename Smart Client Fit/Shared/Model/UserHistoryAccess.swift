//
//  UserHistoryAccess.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import Foundation

struct UserHistoryAccess: Codable {
    let data: [Data]?
    let success: Bool?
    
    struct Data: Codable, Identifiable {
        let id: UUID = UUID()
        let historyID: String?
        let type: String?
        let attributes: Attributes?
        
        enum CodingKeys: String, CodingKey {
            case historyID = "id"
            case type, attributes
        }
        
        struct Attributes: Codable {
            let personId: Int?
            let locationId: Int?
            let originalLocationId: Int?
            let createdAt: String?
            
            enum CodingKeys: String, CodingKey {
                case personId = "person-id"
                case locationId = "location-id"
                case originalLocationId = "original-location-id"
                case createdAt = "created-at"
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

extension UserHistoryAccess.Data.Attributes {
    var locationName: String {
        if let locations = try? DataManager.shared.get(on: .locations, Locations.self),
           let data = locations.data,
           let attributes = data.data,
           let filtered = attributes.first(where: { $0.id == "\(self.locationId ?? -1)" }),
           let attribute = filtered.attributes,
           let name = attribute.name {
            return name
        }
        
        return ""
    }
}
