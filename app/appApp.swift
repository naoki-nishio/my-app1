//
//  appApp.swift
//  app
//
//  Created by Nishio Naoki on 2022/10/25.
//

import SwiftUI

@main
struct appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
