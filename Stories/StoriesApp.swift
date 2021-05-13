//
//  StoriesApp.swift
//  Stories
//
//  Created by Carlos Henrique on 13/05/21.
//

import SwiftUI

@main
struct StoriesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
