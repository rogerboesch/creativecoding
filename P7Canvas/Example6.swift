//
//  Example6.swift
//  P7Canvas
//
//  Loop Touch, 6-09
//  http://learningprocessing.com/examples/chp06/example-06-09-loop-mouse
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example6 : P7Program {
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Loop Touch"
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
        p7background(0)
        
        // Start with i as 0
        var i: CGFloat = 0
        
        // While i is less than the width of the window
        while (i < p7width()) {
            p7noStroke()
            // The distance between the current rectangle
            // and the mouse is equal to the absolute value
            // of the difference between i and mouseX.
            let distance = abs(p7touchX() - i)
            
            // That distance is used to fill the color of
            // a rectangle at horizontal location i.
            p7fill(Int(distance))
            p7rect(i, 0, 10, p7height())
            
            // Increase i by 10
            i += 10
        }
    }
    
    // -------------------------------------------------------------------------
    
}
