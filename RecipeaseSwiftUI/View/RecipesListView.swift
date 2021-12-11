//
//  RecipesListView.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject var viewModel: RecipeListViewModel
    
    var body: some View {
        
        Group {
            if viewModel.isLoading {
                Text("Searching for recipes...")
                    .font(.custom("Chalkduster", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                if viewModel.recipes.isEmpty {
                    Text("No recipes found...")
                        .font(.custom("Chalkduster", size: 24))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.recipes) { recipe in
                                RecipeCellView(viewModel: recipe)
                                    .padding(.horizontal)
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("Recipes")
        .navigationBarHidden(false)
        .background(Color(.darkGrey).edgesIgnoringSafeArea(.all))
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView(viewModel: .init() )
    }
}
