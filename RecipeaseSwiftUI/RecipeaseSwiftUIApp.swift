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
    
    init() {
        setupNavigationBar()
        setupTabBar()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBar.appearance()
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Chalkduster", size: 26)!,
        ]
        
        appearance.barStyle = UIBarStyle.black
        appearance.tintColor = UIColor(named: "Green")
    }
    
    private func setupTabBar() {
        let appearance = UITabBar.appearance()
        appearance.unselectedItemTintColor = UIColor(named: "Lightgrey")
        appearance.barTintColor = UIColor(named: "Darkgrey")
    }
}
