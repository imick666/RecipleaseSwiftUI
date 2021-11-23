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
                    Text("ReciPlease")
                        .font(.custom("Chalkduster", size: 26))
                        .foregroundColor(.white)
                    
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
                    
                    Divider()
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Your ingredients :")
                            
                            Spacer()
                            
                            Button("Clear") {
                                self.viewModel.clearIngredients()
                            }
                            .buttonStyle(RoundedRectangleButtonStyle(color: .lightGrey))
                        }
                        .padding(.horizontal)
                        
                        
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
                            }
                            
                        }
                        
                    }
                    .font(.custom("Chalkduster", size: 16))
                    .foregroundColor(.white)
                }
                
                VStack {
                    
                    Spacer()
                    
                    Button("Search for recipes") {
                        
                    }
                    .buttonStyle(LargeRoundedRectangleButtonStyle(color: .green))
                    .padding()
                    
                    
                }
            }
            .navigationBarHidden(true)
            .background(Color(.darkGrey).edgesIgnoringSafeArea(.all))
            
        }
        
    }
}

struct ShearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
