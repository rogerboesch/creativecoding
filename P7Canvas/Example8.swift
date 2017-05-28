//
//  Example8.swift
//  P7Canvas
//
//  Oscillation, 13-06
//  http://learningprocessing.com/examples/chp13/example-13-05-polar-cartesian
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example8 : P7Program {
    
    var r: CGFloat = 160
    var theta: CGFloat = 0
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Oscillation"
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
        
        // The output of the sin() function oscillates smoothly between 1 and 1.
        // By adding 1 we get values between 0 and 2.
        // By multiplying by 100, we get values between 0 and 200 which can be used as the ellipse's x location.
        let x1 = (sin(theta) + 1) * p7width()/2
        let x2 = (sin(-theta) + 1) * p7width()/2
        
        // With each cycle, increment theta
        theta += 0.05
        
        // Draw the ellipse at the value produced by sine
        p7stroke(0)
        
        p7fill(0)
        p7line(p7width()/2, 0, x1, p7height()/2)
        p7ellipse(x1, p7height()/2, 32, 32)
        
        p7line(p7width()/2, 0, x2, p7height()/2)
        p7fill(255, 0, 0)
        p7ellipse(x2, p7height()/2, 32, 32)
    }
    
    // -------------------------------------------------------------------------
    
}
