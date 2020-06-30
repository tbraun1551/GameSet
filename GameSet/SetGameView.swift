//
//  SetGameView.swift
//  GameSet
//
//  Created by Thomas Braun on 6/24/20.
//

import SwiftUI

struct SetGameView: View {
	
	@ObservedObject var viewModel: SetViewModel = SetViewModel()
	
	private let layout = [GridItem(.adaptive(minimum: 80))]
	private var flyinLocation: CGSize {
		let x = Locations.DealLocationX
		let y = Locations.DealLocationX
		return CGSize(width: x, height: y)
	}
	private var flyoutLocation: CGSize {
		let x = Locations.ScoreLocationX
		let y = Locations.ScoreLocationX
		return CGSize(width: x, height: y)
	}
	
	private let deckLocation1: CGSize = CGSize(width: 275.0, height: 753.0)
	var location: (CGFloat, CGFloat) = (0.0, 0.0)
	
	let columns = [GridItem(.adaptive(minimum: 80))]
	
	var body: some View {
		VStack {
			HStack {
				Label("Score: \(viewModel.score)", systemImage: "face.dashed").font(.title).padding(.leading)
				Spacer()
				
			}
			Grid(viewModel.dealtCards) { card in
				CardView(card: card)
					//					.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .leading)))
					.transition(.asymmetric(insertion: .offset(flyinLocation), removal: .move(edge: .top)))
					.padding()
					.onTapGesture { withAnimation { viewModel.choose(card) } }
			} .onAppear { withAnimation(.easeInOut(duration: 1)) { deal(12) } }
			Divider()
			HStack {
				CreateNewGameButton(viewModel: viewModel)
				GeometryReader { geo in
					DealNewCardbutton(viewModel: viewModel, deal: deal) .onAppear {
						Locations.DealLocationX = geo.frame(in: .global).midX
						Locations.DealLocationY = geo.frame(in: .global).midY
					}
				}
			}.padding(.horizontal).frame(maxHeight: 50)
		}
	}
	func deal(_ numberOfCards: Int) {
		for i in 0..<numberOfCards {
			Timer.scheduledTimer(withTimeInterval: 0.3 * Double(i), repeats: false) { _ in
				withAnimation(.easeInOut(duration: 5)) {
					viewModel.deal()
				}
			}
		}
	}
	
	struct DealNewCardbutton: View {
		
		var viewModel: SetViewModel
		let deal: (Int) -> Void
		
		init(viewModel: SetViewModel, deal: @escaping (Int) -> Void) {
			self.viewModel = viewModel
			self.deal = deal
		}
		
		var body: some View {
			GeometryReader { geo in
				Button(action: {
					deal(3)
					print(Locations.DealLocationX, Locations.DealLocationY)
				}){
					ZStack {
						RoundedRectangle(cornerRadius: 10.0).foregroundColor(.blue)
						Text("Deal Three Cards").foregroundColor(.white)
					}
				}.onAppear {
					print(geo.frame(in: .global).midX, geo.frame(in: .global).midY)
				}
			}
		}
	}
	
	struct CreateNewGameButton: View {
		
		var viewModel: SetViewModel
		
		init(viewModel: SetViewModel) {
			self.viewModel = viewModel
		}
		var body: some View {
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
		}
	}
	
	
	//MARK: - CardView
	struct CardView: View {
		var card: SetModel.Card
		
		var body: some View {
			GeometryReader { geometry in
				withAnimation {
					body(for: geometry.size)
				}
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
		
		
		
		private func linearGradient(color: Color) -> LinearGradient {
			LinearGradient(gradient: Gradient(colors: [.clear, .clear, color, color, .clear, color, color, .clear, color, color, .clear, color, color, .clear, .clear]), startPoint: .leading, endPoint: .trailing)
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


