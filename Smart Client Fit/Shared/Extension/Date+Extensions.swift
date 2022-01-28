//
//  Date+Extensions.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import Foundation

extension Date {
    static func getDateFor(days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: Date())
    }
    
    func formatted(with dateFormat: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}

extension String {
    func formatted(on currentFormat: String, with dateFormat: String) -> String {
        let currentFormatter = DateFormatter()
        currentFormatter.dateFormat = currentFormat
        let date = currentFormatter.date(from: String(self.replacingOccurrences(of: "T", with: "-").prefix(16))) ?? Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}
