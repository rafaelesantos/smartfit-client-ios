//
//  CardView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import SwiftUI

struct CardView: View {
    @Binding var isCardTapped: Bool
    var card: Card
    var date: String
    let unitPoints: [UnitPoint] = [.bottomTrailing, .topLeading, .leading, .center, .bottom, .bottomLeading, .top, .topTrailing]
    
    var body: some View {
        VStack {
            HStack {
                Text(card.cardNumber)
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 14))
                Spacer()
            }
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("\(date)")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                    Text("R$ \(String(format: "%.2f", Double(card.cardCurrency) ?? 0).replacingOccurrences(of: ".", with: ","))")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 28))
                }
                Spacer()
                Image(card.cardProviderLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 40)
                    .padding(.trailing, 9)
            }
        }
        .frame(height: 200)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [card.linearColor1, card.linearColor2]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .cornerRadius(15)
        .shadow(color: card.shadow.opacity(0.4), radius: 15, x: 0, y: 0)
        //.scaleEffect(self.isCardTapped ? 1 : 1.20)
        .rotationEffect(Angle(degrees: self.isCardTapped ? 0 : 90))
        .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
        .onTapGesture {
            self.isCardTapped.toggle()
        }
    }
}
