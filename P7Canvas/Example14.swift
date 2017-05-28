//
//  Example14.swift
//  P7Canvas
//
//  Rotation
//  https://www.funprogramming.org/67-Circular-motion-sine-and-her-cousin.html
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example14 : P7Program {
    var rot: CGFloat = 0
   
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Rotation"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        p7size(p7width(), p7width())
        p7background(0)
        p7rectMode(CORNER)
        p7colorMode(HSB)
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        var x: CGFloat = 0
        
        while (x < 8) {
            var y: CGFloat = 0
            
            while (y < 8) {
                // we give a unique rotation amount to each rectangle, depending
                // on which column and row the rectangle is located (x and y)
                drawRotatingRectangle(60 + x * 40, 75 + y * 30, 16, rot + x*y+y*y)
                y = y + 1
            }
            
            x = x + 1
        }
        
        rot = rot + 8
    }

    // -------------------------------------------------------------------------

    func drawRotatingRectangle(_ x: CGFloat, _ y: CGFloat, _ rect_size: CGFloat, _ r: CGFloat) {
        let co = p7map(r, 0, 5000, 0, 100)
        p7fill(Int(co), 100, 100)

        p7rect(x, y, rect_size, rect_size, r)
    }

    // -------------------------------------------------------------------------
    
}
