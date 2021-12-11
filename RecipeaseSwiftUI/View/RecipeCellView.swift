//
//  RecipeCellView.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import SwiftUI

struct RecipeCellView: View {
    
    @ObservedObject var viewModel: RecipeCellViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                
                GeometryReader { proxy in
                    ZStack {
                        Color.white
                        
                        VStack {
                            Text("\(viewModel.yield)")
                            Text("\(viewModel.time)")
                        }
                        .frame(width: proxy.size.width * 0.9, height: proxy.size.height * 0.9)
                        .background(Color(.darkGrey))
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                    }
                }
                .frame(width: 80, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top)
                .padding(.horizontal)
            }
            
            HStack {
                Text(viewModel.name)
                    .font(.title3)
                    .lineLimit(0)
                
                Spacer()
            }
            .padding()
            .background(Color(.darkGrey).opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding([.horizontal, .bottom], 8)
            
            
            
        }
        .background(background)
        .clipped()
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 8)
        .navigationBarHidden(true)
        
        
    }
    
    private var background: some View {
        if let data = viewModel.image,
           let uiImage = UIImage(data: data) {
            return AnyView(
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            )
            
        } else {
            return AnyView(
                Color(.lightGrey)
            )
        }
    }
    
}

struct RecipeCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView(viewModel: .init())
            .background(Color(.darkGrey)
                            .edgesIgnoringSafeArea(.all))
    }
}
