//
//  FootballSearchApp.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import SwiftUI

@main
struct FootballSearchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
