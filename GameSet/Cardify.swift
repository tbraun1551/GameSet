//
//  Cardify.swift
//  Memorize
//
//  Created by Thomas Braun on 6/11/20.
//  Copyright © 2020 Thomas Braun. All rights reserved.
//

import SwiftUI

//AnimatableModifier combines ViewModifier and Animatable
struct Cardify: AnimatableModifier {
	var rotation: Double = 0
	var animatableData: Double {
		get { return rotation }
		set { rotation = newValue}
	}
	//	var isFaceUp: Bool {
	//		rotation < 90
	//	}
	
	init(isSelected: Bool, accentColor: Color) {
		self.isSelected = isSelected
		self.color = accentColor
	}
	var isSelected: Bool
	var color: Color
	private let cornerRadius: CGFloat = 10.0
	private let edgeLineWidth: CGFloat = 3.0
	
	
	func body(content: Content) -> some View {
		ZStack {
			RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
			RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).foregroundColor(color)
			content
			RoundedRectangle(cornerRadius: cornerRadius).fill(color).opacity(isSelected ? 0.25 : 0)
		}
		.rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
		.aspectRatio(2/3, contentMode: .fit)
	}
}


extension View {
	func cardify(isSelected: Bool, accentColor: Color) -> some View {
		self.modifier(Cardify(isSelected: isSelected, accentColor: accentColor))
	}
}
