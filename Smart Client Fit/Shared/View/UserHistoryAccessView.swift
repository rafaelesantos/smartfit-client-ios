//
//  UserHistoryAccessView.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import SwiftUI

struct UserHistoryAccessView: View {
    
    var userHistoryAccess: UserHistoryAccess
    var locations: [Locations.Data.DataAttributes]
    var amount: Int
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Acessos dos últimos \(amount) dias") {
                if let count = userHistoryAccess.data?.count, count > 0 {
                    ForEach(0 ..< count, id: \.self) { item in
                        Divider().padding(.vertical, 2)
                        
                        HStack() {
                            let item = userHistoryAccess.data?[count - 1 - item]
                            let creatAt = item?.attributes?.createdAt ?? ""
                            let locationName = locations.first(where: { $0.id == "\(item?.attributes?.locationId ?? 0)" })?.attributes?.name ?? ""
                            Group {
                                Text(creatAt.formatted(on: "yyyy-MM-dd-HH:mm", with: "HH:mm"))
                                    .bold()
                                    .font(.footnote)
                            }
                            .frame(width: 50, height: 30, alignment: .center)
                            .background(Color.accentColor.opacity(0.2))
                            .cornerRadius(5)
                            
                            Spacer(minLength: 10)
                            
                            VStack(alignment: .trailing, spacing: 5) {
                                Text((creatAt.formatted(on: "yyyy-MM-dd-HH:mm", with: "EEEE, dd MMMM yyyy")))
                                    .bold()
                                    .font(.footnote)
                                Text(locationName)
                                    .bold()
                                    .font(.footnote)
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }.foregroundColor(.primary)
        }
    }
}
