//
//  RecipeView.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 11/12/2021.
//

import SwiftUI

struct RecipeView: View {
    
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if let data = viewModel.image,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: nil, maxHeight: screenSize.height / 4.5, alignment: .center)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            Text(viewModel.title)
                                .font(.custom("Chalkduster", size: 20))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(.darkGrey).opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding([.bottom, .horizontal], 8)
                            , alignment: .bottom)
                }
                
                
                
                Text("Ingredients :")
                    .font(.custom("Chalkduster", size: 16))
                    .foregroundColor(.white)
                    .underline()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.ingredients, id: \.self) { ingredient in
                            Text("- " + ingredient)
                                .padding(.leading)
                        }
                        
                        Spacer(minLength: 70)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Chalkduster", size: 14))
                    .foregroundColor(.white)
                }
            }
            
            Link(destination: viewModel.url) {
                Text("Open in \(viewModel.source)")
            }
            .buttonStyle(RoundedRectangleButtonStyle(color: .green).large())
            
            
        }
        .padding()
        .background(Color(.darkGrey).edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: viewModel.isStored ? "star.fill" : "star")
                }

            }
        }
        
    }
    
    private func image() -> some View {
        if let data = viewModel.image,
           let uiImage = UIImage(data: data) {
            return AnyView(
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            )
            
        } else {
            return AnyView(
                Color(.lightGrey)
            )
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeView(viewModel: RecipeViewModel.preview[1])
        }
    }
}
