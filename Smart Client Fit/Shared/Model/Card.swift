//
//  Card.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var cardNumber: String
    var cardProviderLogo: String
    var cardCurrency: String
    var cardAmount: Int
    var linearColor1: Color
    var linearColor2: Color
    var shadow: Color
}

extension Card {
    static var sample: Card {
        return Card(cardNumber: "6227 9067 1159 4103", cardProviderLogo: "visa-icon", cardCurrency: "AKZ", cardAmount: 1234564, linearColor1: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), linearColor2: Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), shadow: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
    }
}
