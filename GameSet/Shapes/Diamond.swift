//
//  Diamond.swift
//  GameSet
//
//  Created by Thomas Braun on 6/13/20.
//  Copyright © 2020 Thomas Braun. All rights reserved.
//

import Foundation
import SwiftUI

struct Diamond: Shape {
	func path(in rect: CGRect) -> Path {
		var p = Path()
		
		let top = CGPoint(x: rect.midX, y: rect.maxY)
		let bottom = CGPoint(x: rect.midX, y: rect.minY)
		let right = CGPoint(x: rect.maxX, y: rect.midY)
		let left = CGPoint(x: rect.minX, y: rect.midY)
				
		p.move(to: top)
		p.addLine(to: right)
		p.addLine(to: bottom)
		p.addLine(to: left)
		p.addLine(to: top)

		
		return p
	}
}
