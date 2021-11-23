//
//  RoundedRectangle.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 23/11/2021.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
    
    var color: Color.AssetColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(color))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .font(.custom("Chalkduster", size: 16))
    }
}
