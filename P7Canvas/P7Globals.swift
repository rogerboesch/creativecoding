//
//  P7Globals.swift
//  P7Canvas - Global variables
//
//  Created by Roger Boesch on 24.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import UIKit


// -----------------------------------------------------------------------------
// MARK: - Globals

public var _frameRate = 60

public var _view: UIView?
public var _canvas: P7Canvas?
public var _context: CGContext?

public var _pixelBuffer: [UInt8]?
public var _pixelBufferWidth = 0
public var _pixelBufferHeight = 0

public var _clearMode = OFF
public var _colorMode = RGB

public var _rectMode = CENTER
public var _strokeCap = NORMAL
public var _strokeWidth: CGFloat = 1

public var _fillMode = ON
public var _fillColor = Color(0, 0, 0)
public var _alphaState: Int = 255

public var _textAlign = LEFT
public var _textSize: CGFloat = 14
public var _textFont = UIFont.systemFont(ofSize: 14)

public var _touched = false
public var _touchPoint = CGPoint.zero
public var _touchPointPrevious = CGPoint.zero

// -----------------------------------------------------------------------------
// MARK: - Global Types

public struct Color {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 255
    
    init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int = 255) {
        r = CGFloat(red)
        g = CGFloat(green)
        b = CGFloat(blue)
        a = CGFloat(alpha)
    }
    
    init(_ red: Int) {
        r = CGFloat(red)
        g = CGFloat(red)
        b = CGFloat(red)
        a = 255
    }
    
    func uiColor() -> UIColor {
        let color = UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/255.0)
        return color
    }
    
    func hsbColor() -> UIColor {
        let color = UIColor(hue: r/100.0, saturation: g/100.0, brightness: b/100.0, alpha: a/100.0)
        return color
    }
    
}

public func == (lhs: Color, rhs: Color) -> Bool {
    return lhs.r == rhs.r && lhs.g == rhs.g && lhs.b == rhs.b
}

public func != (lhs: Color, rhs: Color) -> Bool {
    return lhs.r != rhs.r || lhs.g != rhs.g || lhs.b != rhs.b
}

public struct Vector {
    var x: CGFloat = 0
    var y: CGFloat = 0
}

// Alignment
public let LEFT: Int = 0
public let CENTER: Int = 1
public let RIGHT: Int = 2
public let CORNER: Int = 3

// Stroke caps
public let NORMAL: Int = 0
public let ROUND: Int = 1

// Color modes
public let RGB: Int = 0
public let HSB: Int = 1

// Mode's on/off
public let OFF: Int = 0
public let ON: Int = 1

// -----------------------------------------------------------------------------
// MARK: - Global functions

public func p7millis() -> CGFloat {
    return CGFloat(CFAbsoluteTimeGetCurrent())
}

// -----------------------------------------------------------------------------
