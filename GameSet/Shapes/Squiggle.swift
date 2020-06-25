//
//  Squiggle.swift
//  GameSet
//
//  Created by Thomas Braun on 6/18/20.
//  Copyright © 2020 Thomas Braun. All rights reserved.
//

import SwiftUI


struct Squiggle: Shape {
	
	func path(in rect: CGRect) -> Path {
		let dX = rect.width / 100
		let dY = rect.height / 100
		let originX = rect.minX
		let originY = rect.minY
		var path = Path()
		
		let points: [CGPoint] = [
			CGPoint(x: originX + (dX * 0), y: originY + (dY * 50)),
			CGPoint(x: originX + (dX * 10), y: originY + (dY * 5)),
			CGPoint(x: originX + (dX * 30), y: originY + (dY * 7)),
			CGPoint(x: originX + (dX * 50), y: originY + (dY * 20)),
			CGPoint(x: originX + (dX * 65), y: originY + (dY * 25)),
			CGPoint(x: originX + (dX * 85), y: originY + (dY * 0)),
			CGPoint(x: originX + (dX * 90), y: originY + (dY * 5)),
			CGPoint(x: originX + (dX * 100), y: originY + (dY * 50)),
			CGPoint(x: originX + (dX * 90), y: originY + (dY * 95)),
			CGPoint(x: originX + (dX * 70), y: originY + (dY * 93)),
			CGPoint(x: originX + (dX * 50), y: originY + (dY * 80)),
			CGPoint(x: originX + (dX * 35), y: originY + (dY * 75)),
			CGPoint(x: originX + (dX * 15), y: originY + (dY * 100)),
			CGPoint(x: originX + (dX * 10), y: originY + (dY * 95)),
			CGPoint(x: originX + (dX * 0), y: originY + (dY * 50)),
			CGPoint(x: originX + (dX * 10), y: originY + (dY * 5))
		]
		
		var startPoint = CGPoint()
		var previousPoint = CGPoint()
		
		for (index, point) in points.enumerated() {
			switch index {
			case 0:
				startPoint = point
			case 1:
				path.move(to: startPoint.midPoint(to: point))
				previousPoint = point
			default:
				path.addQuadCurve(to: previousPoint.midPoint(to: point), control: previousPoint)
				previousPoint = point
			}
		}
		path.addQuadCurve(to: previousPoint.midPoint(to: startPoint), control: previousPoint)
		path.closeSubpath()
		return path
	}
}

extension CGPoint {
	func midPoint(to destination: CGPoint) -> CGPoint {
		return CGPoint(x: (x + destination.x) / 2, y: (y + destination.y) / 2)
	}
}

struct Squiggle_Previews: PreviewProvider {
	static var previews: some View {
		Squiggle()
	}
}
//struct Squiggle: Shape {
//	func path(in rect: CGRect) -> Path {
//
//		// MARK: TODO : make this into actual squiggle
//
//		var p = Path()
//
//		p.addRect(rect)
//
//		return p
//	}
//}
