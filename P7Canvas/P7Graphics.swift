//
//  P7Graphics.swift
//  P7Canvas - Graphics
//
//  Created by Roger Boesch on 24.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import UIKit

// -----------------------------------------------------------------------------
// MARK: - Colors

public func p7colorMode(_ mode: Int) {
    _colorMode = mode
}

// -----------------------------------------------------------------------------

public func p7background(_ r: Int, _ g: Int, _ b: Int, _ a: Int = 255) {
    guard _canvas != nil else { return }
    
    let color = UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/255.0)
    _canvas!.backgroundColor = color
}

// -----------------------------------------------------------------------------

public func p7background(_ r: Int) {
    guard _canvas != nil else { return }
    
    let color = UIColor(red: CGFloat(r)/255.0, green: CGFloat(r)/255.0, blue: CGFloat(r)/255.0, alpha: 1.0)
    _canvas!.backgroundColor = color
}

// -----------------------------------------------------------------------------

public func p7fill(_ color: Color) {
    _fillColor = color
}

// -----------------------------------------------------------------------------

public func p7fill(_ r: Int, _ g: Int, _ b: Int, _ a: Int = 255) {
    _fillColor = Color(r, g, b, a)
}

// -----------------------------------------------------------------------------

public func p7fill(_ r: Int) {
    _fillColor = Color(r, r, r, 255)
}

// -----------------------------------------------------------------------------

public func p7alpha(_ alpha: Int) {
    _alphaState = alpha
}

// -----------------------------------------------------------------------------
// MARK: - Settings

public func p7rectMode(_ mode: Int) {
    _rectMode = mode
}

// -----------------------------------------------------------------------------

public func p7strokeCap(_ cap: Int) {
    _strokeCap = cap
}

// -----------------------------------------------------------------------------

public func p7noStroke() {
    // TODO: Not implemented so far
}

// -----------------------------------------------------------------------------

public func p7stroke(_ width: CGFloat) {
    _strokeWidth = width
}

// -----------------------------------------------------------------------------

public func p7fillMode(_ mode: Int) {
    _fillMode = mode
}

// -----------------------------------------------------------------------------
// MARK: - Primitives

public func p7line(_ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int) {
    p7line(CGFloat(x1), CGFloat(y1), CGFloat(x2), CGFloat(y2))
}

// -----------------------------------------------------------------------------

public func p7line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
    let aPath = UIBezierPath()
    aPath.move(to: CGPoint(x:x1, y:y1))
    aPath.addLine(to: CGPoint(x:x2, y:y2))
    aPath.close()

    _context!.setFillColor(uiColorByMode(_fillColor).cgColor)
    _context!.setStrokeColor(uiColorByMode(_fillColor).cgColor)
    _context!.setLineWidth(_strokeWidth)
    
    _context!.setAlpha(CGFloat(_alphaState)/255.0)

    aPath.stroke()
}

// -----------------------------------------------------------------------------

public func p7rect(_ x: Int, _ y: Int, _ w: Int, _ h: Int, _ angle: Int = 0) {
    p7rect(CGFloat(x), CGFloat(y), CGFloat(w), CGFloat(h), CGFloat(angle))
}

// -----------------------------------------------------------------------------

public func p7rect(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ angle: CGFloat = 0) {
    guard _context != nil && _view != nil else { return }
    
    _context!.setFillColor(uiColorByMode(_fillColor).cgColor)
    _context!.setStrokeColor(uiColorByMode(_fillColor).cgColor)
    _context!.setLineWidth(_strokeWidth)
    
    _context!.setAlpha(CGFloat(_alphaState)/255.0)
    
    var rect = CGRect(x: x-w/2, y: y-h/2, width: w, height: h)
    if _rectMode == CORNER {
        rect = CGRect(x: x, y: y, width: w, height: h)
    }

    if angle > 0 {
        let x = rect.origin.x
        let y = rect.origin.y
        
        _context?.translateBy(x: x, y: y)
        _context?.rotate(by: degToRad(angle))
        rect.origin.x = 0
        rect.origin.y = 0

        if _rectMode == CENTER {
            rect.origin.x = -(w/2)
            rect.origin.y = -(h/2)
        }

        let path = CGPath(rect: rect, transform: nil)
        _context!.addPath(path)
        _context!.drawPath(using: .fillStroke)

        _context?.rotate(by: -degToRad(angle))
        _context?.translateBy(x: -x, y: -y)
    }
    else {
        
        let path = CGPath(rect: rect, transform: nil)
        _context!.addPath(path)
        _context!.drawPath(using: .fillStroke)
    }
}

// -----------------------------------------------------------------------------

public func p7ellipse(_ x: Int, _ y: Int, _ w: Int, _ h: Int) {
    p7ellipse(CGFloat(x), CGFloat(y), CGFloat(w), CGFloat(h))
}

// -----------------------------------------------------------------------------

public func p7ellipse(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
    guard _context != nil && _view != nil else { return }
    
    _context!.setFillColor(uiColorByMode(_fillColor).cgColor)
    _context!.setStrokeColor(uiColorByMode(_fillColor).cgColor)
    _context!.setLineWidth(_strokeWidth)
    
    _context!.setAlpha(CGFloat(_alphaState)/255.0)
    
    var rect = CGRect(x: CGFloat(x-w/2), y: CGFloat(y-h/2), width: CGFloat(w), height: CGFloat(h))
    if _rectMode == CORNER {
        rect = CGRect(x: x, y: y, width: w, height: h)
    }
    
    let path = CGPath(ellipseIn: rect, transform: nil)
    _context!.addPath(path)
    
    if _fillMode == ON {
        _context!.drawPath(using: .fillStroke)
    }
    else {
        _context!.drawPath(using: .stroke)
    }
}

// -----------------------------------------------------------------------------
// MARK: - Text

public func p7textAlign(_ align: Int = LEFT) {
    _textAlign = align
}

// -----------------------------------------------------------------------------

public func p7textSize(_ size: Int) {
    _textSize = CGFloat(size)
    _textFont = UIFont.systemFont(ofSize: _textSize)
}

// -----------------------------------------------------------------------------

public func p7text(_ text: String, _ x: Int, _ y: Int) {
    p7text(text, CGFloat(x), CGFloat(y))
}

// -----------------------------------------------------------------------------

public func p7text(_ text: String, _ x: CGFloat, _ y: CGFloat) {
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.lineSpacing = 6.0
    paraStyle.alignment = .left
    
    if _textAlign == CENTER {
        paraStyle.alignment = .center
    }
    else if _textAlign == RIGHT {
        paraStyle.alignment = .right
    }
    
    let skew = 0.1
    
    let attributes: Dictionary<String, Any> = [
        NSForegroundColorAttributeName: uiColorByMode(_fillColor),
        NSParagraphStyleAttributeName: paraStyle,
        NSObliquenessAttributeName: skew,
        NSFontAttributeName: _textFont
    ]
    
    _context!.setFillColor(uiColorByMode(_fillColor).cgColor)
    
    let rect = CGRect(x: CGFloat(0), y: CGFloat(y), width: CGFloat(p7width()), height: CGFloat(p7height()))
    text.draw(in: rect, withAttributes: attributes)
}

// -----------------------------------------------------------------------------

public func p7text(_ number: Int, _ x: Int, _ y: Int) {
    p7text(number, CGFloat(x), CGFloat(y))
}

// -----------------------------------------------------------------------------

public func p7text(_ number: Int, _ x: CGFloat, _ y: CGFloat) {
    let str = "\(number)"
    p7text(str, x, y)
}

// -----------------------------------------------------------------------------
// MARK: - Matrix operations

public func p7rotate(_ angle: CGFloat) {
    _context?.rotate(by: degToRad(angle))
}

// -----------------------------------------------------------------------------
// MARK: - Internals

public func radToDeg(_ val: CGFloat) -> CGFloat {
    return 180.0 * val / CGFloat(Double.pi)
}

// -----------------------------------------------------------------------------

public func degToRad(_ val: CGFloat) -> CGFloat {
    return CGFloat(Double.pi) * val / 180.0
}

// -----------------------------------------------------------------------------

private func uiColorByMode(_ color: Color) -> UIColor {
    if _colorMode == HSB {
        return color.hsbColor()
    }

    return color.uiColor()
}

// -----------------------------------------------------------------------------
