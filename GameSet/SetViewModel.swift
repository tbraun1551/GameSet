//
//  SetViewModel.swift
//  GameSet
//
//  Created by Thomas Braun on 6/24/20.
//

import SwiftUI


class SetViewModel: ObservableObject {
	@Published private var model: SetModel = SetViewModel.createSetGame()
	
	static private let numberOfCards = 81
	
	private static func createSetGame() -> SetModel {
		var cardFaces = [(CardContent, Int, Color )]()
		let availableColors: [Color] = [.red, .green, .blue]
		
		for number in 1...3 {
			for shape in CardContent.Shape.allCases {
				for color in availableColors {
					for shading in CardContent.Shading.allCases {
						cardFaces.append((CardContent(shape: shape, shading: shading), number, color))
					}
				}
			}
		}
		
		return SetModel(numberOfCards: numberOfCards) { cardIndex in return cardFaces[cardIndex]}
	}
	
	func createNewGame() {
		model = SetViewModel.createSetGame()
		model.dealCards()
	}
	
	
	//MARK: - Access To The Model
	var deck: [SetModel.Card] {
		model.deck
	}
	
	var dealtCards: [SetModel.Card] {
		model.dealtCards
	}
	var score: Int {
		model.score
	}
	var isGameOn: Bool {
		model.isGameOn
	}
	//MARK: - Intents
	func choose(_ card: SetModel.Card) {
		model.choose(card)
	}
	func dealThreeCards() {
		model.dealThreeCards()
	}
	func dealCards() {
		model.dealCards()
	}
	func deal() {
		model.deal()
	}
}
