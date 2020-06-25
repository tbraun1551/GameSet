//
//  CardContentProtocol.swift
//  GameSet
//
//  Created by Thomas Braun on 6/24/20.
//

import SwiftUI

protocol CardContentProtocol {
	var shape: Shape { get }
	var shading: Shading { get }
	
	associatedtype Shape
	associatedtype Shading
}
