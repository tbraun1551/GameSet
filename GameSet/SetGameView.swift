//
//  SetGameView.swift
//  GameSet
//
//  Created by Thomas Braun on 6/24/20.
//

import SwiftUI

struct SetGameView: View {
	
	@ObservedObject var viewModel: SetViewModel = SetViewModel()
	
	let layout = [
		GridItem(.adaptive(minimum: 80))
	]
	
	var body: some View {
		VStack {
			HStack {
				Label("Score: \(viewModel.score)", systemImage: "face.dashed").font(.title)
				Spacer()
			}
			Grid(viewModel.dealtCards) { card in
				CardView(card: card)
					.padding()
					.onTapGesture { viewModel.choose(card) }
			}
			Divider()
			HStack {
				Button( action: {
					withAnimation(.easeInOut) {
						viewModel.createNewGame()
					}
				}) {
					ZStack {
						RoundedRectangle(cornerRadius: 10.0).foregroundColor(.blue)
						Text("New Game").foregroundColor(.white)
					}
				}
				Button(action: {
					withAnimation(.easeInOut) {
						viewModel.dealThreeCards()
					}
				}) {
					ZStack {
						RoundedRectangle(cornerRadius: 10.0).foregroundColor(.blue)
						Text("Deal Three Cards").foregroundColor(.white)
					}
				}
			}.padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/).frame(maxHeight: 50)
		}
	}
	
	
	//MARK: - CardView
	struct CardView: View {
		var card: SetModel.Card
		
		var body: some View {
			GeometryReader { geometry in
				body(for: geometry.size)
			}
		}
		var color: Color {
			card.color
		}
		var shading: Double {
			switch(card.content.shading) {
			case .solid:
				return 1.0
			case .striped:
				return 0.3
			case .open:
				return 0.0
			}
		}
		var numberOfSymbols: Int {
			card.numberOfSymbols
		}
		
		@ViewBuilder
		private func body(for size: CGSize) -> some View {
			VStack {
				ForEach(0..<numberOfSymbols) { _ in
					if card.content.shape == .diamond {
						ZStack {
							Diamond().stroke(lineWidth: lineWidth).foregroundColor(color)
							Diamond().fill(color).opacity(shading)
						}
					} else if card.content.shape == .squiggle {
						ZStack {
							Squiggle().stroke(lineWidth: lineWidth).foregroundColor(color)
							Squiggle().fill(color).opacity(shading)
						}
					}
					if card.content.shape == .oval {
						ZStack {
							Oval().stroke(lineWidth: lineWidth).foregroundColor(color)
							Oval().fill(color).opacity(shading)
						}
					}
				} .aspectRatio(contentMode: .fit)
			} .padding()
			.cardify(isSelected: card.isSelected, accentColor: color)
		}
		
		// MARK: Drawing constants
		
		private let lineWidth: CGFloat = 2.0
		private let aspectRatio: CGFloat = 4/2
		
		private func fontSize(for size: CGSize) -> CGFloat {
			min(size.width, size.height) * 0.7
		}
	}
}



struct SetGameView_Previews: PreviewProvider {
	static var previews: some View {
		SetGameView()
	}
}
