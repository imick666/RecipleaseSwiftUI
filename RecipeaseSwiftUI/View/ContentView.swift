//
//  ContentView.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 15/11/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "Lightgrey")
    }

    var body: some View {
        TabView {
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            Text("Favorites")
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
            
        }
        .accentColor(Color(.green))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
