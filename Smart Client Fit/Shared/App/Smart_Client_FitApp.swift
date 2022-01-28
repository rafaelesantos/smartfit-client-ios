//
//  Smart_Client_FitApp.swift
//  Shared
//
//  Created by Rafael Escaleira on 27/01/22.
//

import SwiftUI

@main
struct Smart_Client_FitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
