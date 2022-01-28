//
//  CoreDataManager.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 27/01/22.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataProvider {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataProvider()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "SmartFitClient")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
