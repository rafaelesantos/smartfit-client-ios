//
//  User.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID = UUID()
    let personal: Personal?
    let emergency_information: String?
    let address: Address?
    let purchase: Purchase?
    let location: Location?
    let plan: Purchase.Plan?
    let country_id: Int?
    let booking_url: String?
    let fitpass_url: String?
    let bank_slip_url: String?
    let has_pending_payments: Bool?
    let wallet: Wallet?
    
    struct Personal: Codable {
        let single_access_token: String?
        let id: Int?
        let name: String?
        let email: String?
        let phone: Phone?
        let personal_group: PersonalGroup?
        let sign_up_at: String?
        let country_locale: String?
        
        struct Phone: Codable {
            let id: Int?
            let number: String?
            let area: String?
            let type: String?
        }
        
        struct PersonalGroup: Codable {
            let document: String?
            let document_kind: String?
            let gender: String?
        }
    }
    
    struct Address: Codable {
        let id: String?
        let address_group_0: AddressGroup_0?
        let street: String?
        let region: String?
        let address_group_1: AddressGroup_1?
        let address_group_2: AddressGroup_2?
        
        struct AddressGroup_0: Codable {
            let zip: String?
        }
        
        struct AddressGroup_1: Codable {
            let number: String?
            let complement: String?
        }
        
        struct AddressGroup_2: Codable {
            let district_id: String?
            let city_id: String?
            let state_id: String?
            let zone: String?
        }
    }
    
    struct Purchase: Codable {
        let id: Int?
        let membership_price: String?
        let plan: Plan?
        let last_freeze: String?
        let allow_to_freeze_on_web: Bool?
        let purchase_benefit_code: String?
        let code_available: Bool?
        let is_corporate: Bool?
        let is_transferable: Bool?
        let anual_fee_date_to_site: String?
        let anual_fee_amount_to_site: Int?
        let purchase_addons: [PurchaseAddons]?
        
        struct Plan: Codable {
            let name: String?
            let status: String?
            let can_create_new_plan: Bool?
        }
        
        struct PurchaseAddons: Codable {
            let expires_at: String?
            let cancelled_at: String?
            let addon_name: String?
            let addon_code: String?
        }
    }
    struct Location: Codable {
        let smart_system_id: Int?
        let name: String?
        let acronym: String?
        let limit_guests: Int?
        let allow_black_visit: Bool?
    }
    
    struct Wallet: Codable {
        let masked_card_number: String?
        let payment_company_name: String?
        let payment_company_active: Bool?
        let payment_company_method: String?
    }
    
    func save(on reference: DataManager.Reference) throws -> Self {
        let defaultEncoded = try self.encoded
        try DataManager.shared.defaults.set(defaultEncoded, forKey: reference.value)
        try DataManager.shared.defaults.synchronize()
        return self
    }
}

extension User {
    var presentedName: String {
        let firstName: String = self.personal?.name?.components(separatedBy: " ").first ?? ""
        let lastName: String = self.personal?.name?.components(separatedBy: " ").last ?? ""
        return firstName + " " + lastName
    }
}

extension Array where Element == User {
    @discardableResult
    func save(on reference: DataManager.Reference) throws -> Self {
        let defaultEncoded = try self.encoded
        try DataManager.shared.defaults.set(defaultEncoded, forKey: reference.value)
        try DataManager.shared.defaults.synchronize()
        return self
    }
}
