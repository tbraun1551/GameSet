//
//  Array+Only.swift
//  Memorize
//
//  Created by Thomas Braun on 6/2/20.
//  Copyright © 2020 Thomas Braun. All rights reserved.
//

import Foundation

extension Array {
	var only: Element? {
		count == 1 ? first : nil
	}
}
