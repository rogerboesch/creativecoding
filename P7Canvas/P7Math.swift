//
//  P7Math.swift
//  P7Canvas - Mathematics
//
//  Created by Roger Boesch on 24.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import UIKit

// -----------------------------------------------------------------------------
// MARK: - Math

public func p7dist(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) -> CGFloat {
    let dx = x2 - x1
    let dy = y2 - y1
    return sqrt(dx*dx + dy*dy)
}

// -----------------------------------------------------------------------------

public func p7round(_ number: CGFloat) -> Int {
    return Int(round(number))
}

// -----------------------------------------------------------------------------

public func p7lerp(_ a: CGFloat, _ b: CGFloat, _ at: CGFloat) -> CGFloat {
    return a + (b - a) * at
}

// -----------------------------------------------------------------------------

public func p7map(_ val: CGFloat, _ min: CGFloat, _ max: CGFloat, _ toMin: CGFloat, _ toMax: CGFloat) -> CGFloat {
    let param = (val - min)/(max -  min)
    return p7lerp(toMin, toMax, param)
}

// -----------------------------------------------------------------------------
// MARK: - Random

public func p7random(_ min: Int, _ max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(1 + max - min))) + min
}

// -----------------------------------------------------------------------------

public func p7random(_ min: CGFloat, _ max: CGFloat) -> Int {
    return Int(arc4random_uniform(UInt32(1 + Int(max) - Int(min)))) + Int(min)
}

// -----------------------------------------------------------------------------

public func p7random(_ max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(1 + max - 0))) + 0
}

// -----------------------------------------------------------------------------

public func p7random(_ max: CGFloat) -> Int {
    return Int(arc4random_uniform(UInt32(1 + Int(max) - 0))) + 0
}

// -----------------------------------------------------------------------------

public func p7randomF(_ max: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(1 + Int(max) - 0))) + 0
}

// -----------------------------------------------------------------------------
