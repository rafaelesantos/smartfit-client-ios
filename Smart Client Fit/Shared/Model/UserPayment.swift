//
//  UserPayment.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import Foundation

struct UserPayment: Codable, Identifiable {
    let id: UUID = UUID()
    let person_id: Int?
    let location_acronym: String?
    let openInstallments: [OpenInstallments]?
    let paidInstallments: [PaidInstallments]?
    let rejectedInstallments: [String]?
    let scheduledInstallments: [String]?
    let lastDueDateDay: String?
    let nextPayment: NextPayment?
    
    struct NextPayment: Codable {
        let id: Int?
        let title: String?
        let dueDate: String?
        let value: String?
        let startAt: String?
        let endAt: String?
        let type: String?
        let lastDueDateDay: String?
    }
    
    struct OpenInstallments: Codable {
        let id: Int?
        let title: String?
        let dueDate: String?
        let value: String?
        let startAt: String?
        let endAt: String?
        let type: String?
        let lastDueDateDay: String?
    }
    
    struct PaidInstallments: Codable {
        let id: Int?
        let title: String?
        let dueDate: String?
        let value: String?
        let flag: String?
        let invoiceKind: String?
        let invoiceValue: String?
        let startAt: String?
        let endAt: String?
        let type: String?
        let siteRpsPath: String?
    }
    
    func save(on reference: DataManager.Reference) throws -> Self {
        let defaultEncoded = try self.encoded
        try DataManager.shared.defaults.set(defaultEncoded, forKey: reference.value)
        try DataManager.shared.defaults.synchronize()
        return self
    }
}

extension Array where Element == UserPayment.OpenInstallments {
    var total: Double {
        let values: [Double] = self.map({ Double($0.value ?? "0") ?? 0 })
        return values.reduce(0, +)
    }
}

extension Array where Element == UserPayment.PaidInstallments {
    var total: Double {
        let values: [Double] = self.map({ Double($0.value ?? "0") ?? 0 })
        return values.reduce(0, +)
    }
}
