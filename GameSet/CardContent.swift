//
//  CardFace.swift
//  GameSet
//
//  Created by Thomas Braun on 6/16/20.
//  Copyright © 2020 Thomas Braun. All rights reserved.
//

import Foundation
import SwiftUI


struct CardContent: CustomStringConvertible, Equatable, CardContentProtocol {
	
//	let number: Number
	let shape: Shape
//	let color: Color
	let shading: Shading
	
	var description: String { return "\(shape), \(shading)"}
	 
    
//	enum Number: Int, CaseIterable, Equatable {
//		case one = 1, two, three //One = 1 makes it index from 1 instead of 0
//	}
	
	enum Shape: CaseIterable, Equatable {
		case diamond, squiggle, oval
	}
	
//	enum Color: CaseIterable, Equatable {
//		case red, green, purple
//	}
	
	enum Shading: CaseIterable, Equatable {
		case solid, striped, open
	}
}


