//
//  Example11.swift
//  P7Canvas
//
//  Convert distances into colors or widths
//  https://www.funprogramming.org/45-Convert-distances-into-colors-or-widths.html
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example11 : P7Program {
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Color Distance"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7size(p7width(), p7width())
        p7background(0)
        p7clearMode(ON)
        p7rectMode(CENTER)
        p7colorMode(HSB)
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        var x: CGFloat = 0
        var a: CGFloat = 0
        
        let rnd1 = p7random(10, 100)
        
        while (x < p7width()) {
            let rnd2 = p7random(0, 20) - 10

            let y = p7map(sin(a)*sin(a*3)*sin(a*4), -1, 1, 50, 250)
            let co = p7map(y, 50, 250, 0, 100)
            let sz = p7map(y, 50, 250, 10, 1)
            
            p7stroke(sz)
            p7fill(Int(co), rnd1, 100)
            p7ellipse(x, y+CGFloat(rnd2), sz, sz)
            x = x + 1
            a = a + 0.03
        }
        
    }
    
    // -------------------------------------------------------------------------
    
}
