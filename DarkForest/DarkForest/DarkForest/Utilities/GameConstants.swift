//
//  GameConstants.swift
//  DarkForest
//
//  Created by MIKHAIL ZHACHKO on 16.02.25.
//

import Foundation

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let edge: UInt32 = 0x1
    static let character: UInt32 = 0x1 << 1
}

struct ZPosition {
    static let background: CGFloat = 0
    static let obstacles: CGFloat = 1
    static let character: CGFloat = 2
}
