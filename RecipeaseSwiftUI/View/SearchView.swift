//
//  ShearchView.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 22/11/2021.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    VStack {
                        Text("What's in your fridge?")
                            .font(.custom("Chalkduster", size: 24))
                        
                        HStack {
                            ZStack(alignment: .bottom) {
                                TextField("Chicken, Potatoes, ...",
                                          text: $viewModel.ingredientTextField,
                                          onCommit: {
                                    self.viewModel.addIngredient()
                                })
                                
                                Color(.lightGrey)
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                                    .offset(x: 0, y: 5)
                                    .opacity(0.5)
                            }
                            
                            
                            Button("Add") {
                                self.viewModel.addIngredient()
                            }
                            .buttonStyle(RoundedRectangleButtonStyle(color: .green))
                            
                        }
                    }
                    .padding()
                    .background(Color.white)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Your ingredients :")
                                .font(.custom("Chalkduster", size: 20))
                            
                            Spacer()
                            
                            Button("Clear") {
                                self.viewModel.clearIngredients()
                            }
                            .buttonStyle(RoundedRectangleButtonStyle(color: .lightGrey))
                        }
                        .padding()
                        
                        if viewModel.ingredients.isEmpty {
                            Text("Please add some ingredients for begin")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(.bottom, 75)
                                .padding()
                                .multilineTextAlignment(.center)
                        } else {
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    ForEach(Array(viewModel.ingredients.enumerated()), id: \.offset) { index, ingredient in
                                        HStack {
                                            Text("- " + ingredient)


                                            Spacer()

                                            Button {
                                                self.viewModel.deleteIngredient(for: index)
                                            } label: {
                                                Image(systemName: "x.circle")
                                            }

                                        }
                                        .padding()
                                    }
                                    
                                    Spacer(minLength: 75)
                                }

                            }
                        }
                        

                    }
                    .font(.custom("Chalkduster", size: 16))
                    .foregroundColor(.white)
                }
                
                VStack {
                    
                    Spacer()
                    
                    NavigationLink(isActive: $viewModel.showResult) {
                        RecipesListView(viewModel: .init(ingredients: viewModel.ingredients))
                    } label: {
                        Text("Search for recipes")
                    }
                    .buttonStyle(RoundedRectangleButtonStyle(color: .green).large())
                    .padding()
                    .disabled(viewModel.ingredients.isEmpty)
                    
                }
                
                

            }
            .navigationBarTitle("Reciplease")
            .background(Color(.darkGrey).edgesIgnoringSafeArea(.all))
            
        }
        
    }
    
}

struct ShearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
