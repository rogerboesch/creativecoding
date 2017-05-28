//
//  Example9.swift
//  P7Canvas
//
//  Recursion, 13-08
//  http://learningprocessing.com/examples/chp13/example-13-08-recursion
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example9 : P7Program {
    
    var theta: CGFloat = 0
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Recursion"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7size(p7width(), p7width())
        
        p7background(255)
        p7clearMode(ON)
        p7rectMode(CENTER)
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        p7background(255)
        p7stroke(1)
        p7fillMode(OFF)
        
        let x = (sin(theta) + 1) * p7width()/2
        
        // With each cycle, increment theta
        theta += 0.05
        
        drawCircle(p7width()/2, p7height()/2, x)
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Recursion method
    
    func drawCircle(_ x: CGFloat, _ y: CGFloat, _ radius: CGFloat) {
        p7ellipse(x, y, radius, radius)
        
        if (radius > 2) {
            // drawCircle() calls itself twice, creating a branching effect.
            // For every circle, a smaller circle is drawn to the left and right.
            drawCircle(x + radius/2, y, radius/2)
            drawCircle(x - radius/2, y, radius/2)
        }
    }
    
    // -------------------------------------------------------------------------
    
}
