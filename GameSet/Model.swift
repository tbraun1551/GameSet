//
//  Model.swift
//  GameSet
//
//  Created by Thomas Braun on 6/24/20.
//

import SwiftUI

struct SetModel {
	private(set) var deck: [Card]
	private(set) var dealtCards: [Card]
	private var matchedCards: [Card] = [Card]()
	private let totalNumberOfCards = 81
	private(set) var score: Int
	private(set) var isGameOn: Bool
	private var chosenCards: [Card] {
		dealtCards.filter( { $0.isSelected } )
	}
	var numberOfChosenCards: Int {
		chosenCards.count
	}
	
	
	init(numberOfCards: Int, cardContentFactory: (Int) -> (CardContent, Int, Color)) {
		deck = [Card]()
		dealtCards = [Card]()
		
		for cardIndex in 0..<numberOfCards {
			let face = cardContentFactory(cardIndex)
			deck.append(Card(isSelected: false, numberOfSymbols: face.1, color: face.2, content: face.0, id: cardIndex))
		}
//		deck.shuffle()
		isGameOn = true
		score = 0
	}
	
	//MARK: - Functions
	mutating func dealCards() {
		deal(12)
	}
	
	
	
	mutating func dealThreeCards() {
		deal(3)
	}
	
	mutating func deal(_ numberOfCards: Int) {
		for _ in 0..<numberOfCards {
			if deck.count > 0 {
				dealtCards.append(deck.removeFirst())
			}
		}
	}
	
	mutating func deal() {
		if deck.count > 0 {
			dealtCards.append(deck.removeFirst())
		}
	}
	mutating func choose(_ card: Card) {
		if numberOfChosenCards >= 3 { checkForSet() }
		if let chosenIndex: Int = dealtCards.firstIndex(matching: card) {
			dealtCards[chosenIndex].isSelected.toggle()
			print("Card chose \(card)")
			print(numberOfChosenCards)
		}
	}
	mutating func d() {
		dealtCards.append(deck.removeFirst())
	}
	
	//MARK: - Functions that check for set
	
	mutating func checkForSet() {
		let card1 = chosenCards[0]
		let card2 = chosenCards[1]
		let card3 = chosenCards[2]
		if colorSet(card1, card2, card3) && numberSet(card1, card2, card3) && shapeSet(card1, card2, card3) && shadingSet(card1, card2, card3) {
			print("You have a set!")
			setCreated()
		} else {
			print("You don't have a set :(")
			setNotCreated()
		}
	}
	
	mutating func setCreated() {
		for card in chosenCards {
			dealtCards.removeElement(card)
			matchedCards.append(card)
		}
		score += 1
		dealThreeCards()
	}
	mutating func setNotCreated() {
		for card in chosenCards {
			dealtCards[dealtCards.firstIndex(matching: card)!].isSelected = false
		}
	}
	func colorSet(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool { return propertiesAreSet(card1.color, card2.color, card3.color) }
	func shapeSet(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool { return propertiesAreSet(card1.content.shape, card2.content.shape, card3.content.shape) }
	func numberSet(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool { return propertiesAreSet(card1.numberOfSymbols, card2.numberOfSymbols, card3.numberOfSymbols) }
	func shadingSet(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool { return propertiesAreSet(card1.content.shading, card2.content.shading, card3.content.shading) }
	func propertiesAreSet<E: Equatable>(_ property1: E, _ property2: E, _ property3: E) -> Bool {
		return (property1 == property2 && property2 == property3) || (property1 != property2 && property1 != property3 && property2 != property3)
	}
	
	
	//MARK: - Card Structure
	struct Card: Identifiable  {
		var isSelected: Bool = false
		var numberOfSymbols: Int
		var color: Color
		var content: CardContent
		var id: Int
	}
}
