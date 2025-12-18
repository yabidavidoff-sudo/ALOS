//
//  ALOSApp.swift
//  ALOS
//
//  Created by yabi davidoff on 2025-12-17.
//

import SwiftUI
import CoreData

@main
struct ALOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
