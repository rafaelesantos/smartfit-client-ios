//
//  DataManager.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private let suiteName = "smartfit.client.18596c16-8571-4121-ac37-f429cb0b09b8."
    
    var defaults: UserDefaults {
        get throws {
            guard let _defaults = UserDefaults(suiteName: suiteName)
            else { throw fatalError() }
            return _defaults
        }
    }
    
    enum Reference {
        case users, userPayment(Int), userHistoryAccess(Int), userSession, currentUser, locations, currentLocation
        var value: String {
            switch self {
            case .users: return "users"
            case .userPayment(let id): return "user.payment.\(id)"
            case .userHistoryAccess(let id): return "user.history.\(id)"
            case .userSession: return "user.session"
            case .currentUser: return "user.current"
            case .locations: return "locations"
            case .currentLocation: return "user.current.location"
            }
        }
    }
    
    @discardableResult
    func get<T>(on reference: DataManager.Reference, _ type: T.Type) throws -> T where T: Codable  {
        return try defaults.value(on: reference, type)
    }
    
    func remove(on reference: DataManager.Reference) throws {
        return try defaults.removeObject(forKey: reference.value)
    }
    
    func dropAll() throws {
        try self.defaults.removePersistentDomain(forName: suiteName)
    }
}

extension UserDefaults {
    func value<T>(on reference: DataManager.Reference, _ type: T.Type) throws -> T where T: Codable {
        let defaultData = try self.value(forKey: reference.value).data
        return try T.decode(from: defaultData)
    }
}

extension Decodable {
    static func decode(from: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: from)
    }
}

extension Encodable {
    var encoded: Data {
        get throws {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(self)
        }
    }
}

extension Optional {
    var data: Data {
        get throws {
            guard let _data = self as? Data else { return Data() }
            return _data
        }
    }
}
