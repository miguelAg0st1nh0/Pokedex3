//
//  Pokedex3App.swift
//  Pokedex3
//
//  Created by Miguel Agostinho on 24/09/2024.
//

import SwiftUI

@main
struct Pokedex3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
