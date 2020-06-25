//
//  Oval.swift
//  GameSet
//
//  Created by Thomas Braun on 6/18/20.
//  Copyright © 2020 Thomas Braun. All rights reserved.
//

import SwiftUI

struct Oval: Shape {
	func path(in rect: CGRect) -> Path {
		// MARK: TODO : replace ellipse by real oval
		
		var p = Path()
		p.addEllipse(in: rect)
		return p
	}
}
