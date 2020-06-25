//
//  Array+Identifiable.swift
//  GameSet
//
//  Created by Thomas Braun on 6/24/20.
//

import Foundation



extension Array where Element: Identifiable { //Only adds this function to arrays with identifiable.
	
	func firstIndex(matching: Element) -> Int? { //Finds index of first element in the Array that matches the one passed through
		for index in 0..<self.count {
			if self[index].id ==  matching.id {
				return index
			}
		}
		return nil
	}
	
	mutating func removeElement(_ element: Element) { //Removes the element passed through from the array
		for index in 0..<self.count {
			if self[index].id == element.id {
				self.remove(at: index)
				break
			}
		}
	}
}
