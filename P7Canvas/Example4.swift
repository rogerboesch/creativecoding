//
//  Example4.swift
//  P7Canvas
//
//  Random painting, 4-7
//  http://learningprocessing.com/examples/chp04/example-04-07-randompainting
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example4 : P7Program {
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Random Painting"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7background(255)
        p7clearMode(OFF)
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        // Each time through draw(), new random
        // numbers are picked for a new ellipse.
        let r = p7random(255)
        let g = p7random(255)
        let b = p7random(255)
        let a = p7random(255)
        let diam = p7random(20)
        let x = p7random(p7width())
        let y = p7random(p7height())
        
        // Use values to draw an ellipse
        p7noStroke()
        p7fill(r, g, b, a)
        p7ellipse(x, y, diam, diam)
    }
    
    // -------------------------------------------------------------------------
    
}
