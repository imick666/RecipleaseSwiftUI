//
//  LargeRoundedRectangleButtonStyle.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 23/11/2021.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    private var color: Color.AssetColor
    
    @State private var isLarge: Bool
    
    public init(color: Color.AssetColor) {
        self.color = color
        self.isLarge = false
    }
    
    private init(color: Color.AssetColor, isLarge: Bool = false) {
        self.color = color
        self.isLarge = isLarge
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: isLarge ? .infinity : nil)
            .background(Color(color))
            .overlay (
                isEnabled ?
                    Color.black.opacity(configuration.isPressed ? 0.2 : 0) :
                    Color.black.opacity(0.3)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .font(.custom("Chalkduster", size: 16).bold())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
       
    func large() -> some ButtonStyle {
        return RoundedRectangleButtonStyle(color: self.color, isLarge: true)
    }
}
