//
//  MapAnnotationView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 30/01/22.
//

import SwiftUI

struct MapAnnotationView: View {
    // MARK: - PROPERTIES
    
    var hour: String
    var locationName: String
    @State private var animation: Double = 0.0
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor)
                .frame(width: 35, height: 35, alignment: .center)
            
            Circle()
                .stroke(Color.accentColor, lineWidth: 2)
                .frame(width: 35, height: 35, alignment: .center)
                .scaleEffect(1 + CGFloat(animation))
                .opacity(1 - animation)
            
            Image(systemName: "building.columns.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(.black)
        }
        .onAppear {
            withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false)) {
                animation = 1
            }
        }
    }
}
