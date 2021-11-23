//
//  RecipeaseSwiftUIApp.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 15/11/2021.
//

import SwiftUI

@main
struct RecipeaseSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
