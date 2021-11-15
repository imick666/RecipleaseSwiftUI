//
//  ContentView.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 15/11/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        Text("Hello World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
