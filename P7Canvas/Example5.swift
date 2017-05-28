//
//  Example5.swift
//  P7Canvas
//
//  Path along edges, 5-08
//  http://learningprocessing.com/examples/chp05/example-05-08-edgespath
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example5 : P7Program {
    
    let SIZE: CGFloat = 20  // Size of cube
    var x: CGFloat = 0      // x location of square
    var y: CGFloat = 0      // y location of square
    var speed: CGFloat = 5  // speed of square
    
    // A variable to keep track of the square's "state."
    // Depending on the value of its state, it will either move right, down, left, or up.
    var state = 0
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Path along Edges"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7size(p7width(), p7width())
        
        p7background(255)
        p7clearMode(ON)
        p7rectMode(CORNER)
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        p7background(255)
        
        // Display the square
        p7stroke(0)
        p7fill(175)
        p7rect(x, y, SIZE, SIZE)
        
        // If the state is 0, move to the right.
        if (state == 0) {
            x = x + speed
            
            // If, while the state is 0, it reaches the right side of the window, change the state to 1
            // Repeat this same logic for all states!?
            if (x > p7width()-SIZE) {
                x = p7width()-SIZE
                state = 1
            }
        } else if (state == 1) {
            y = y + speed
            
            if (y > p7height()-SIZE) {
                y = p7height()-SIZE
                state = 2
            }
        } else if (state == 2) {
            x = x - speed
            
            if (x < 0) {
                x = 0
                state = 3
            }
        } else if (state == 3) {
            y = y - speed
            
            if (y < 0) {
                y = 0
                state=0
            }
        }
    }
    
    // -------------------------------------------------------------------------
    
}
