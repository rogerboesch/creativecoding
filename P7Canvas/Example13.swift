//
//  Example13.swift
//  P7Canvas
//
//  Circular motion
//  https://www.funprogramming.org/67-Circular-motion-sine-and-her-cousin.html
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example13 : P7Program {
    private var a: CGFloat = 0
    private var b: CGFloat = 0
    private var co: CGFloat = 0
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Circular Motion"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(OFF)
        p7size(p7width(), p7width())
        p7background(0)
        p7stroke(3)
        p7colorMode(HSB)
        
        p7frameRate(1000)
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        p7fill(Int(co), 80, 80, 20)
        
        let x0 = p7map(sin(a), -1, 1, 20, p7width() - 20)
        let y0 = p7map(cos(a), -1, 1, 20, p7height() - 20)
        
        let x1 = p7map(sin(b), -1, 1, 20, p7width() - 20)
        let y1 = p7map(cos(b), -1, 1, 20, p7height() - 20)
        
        p7line(x0, y0, x1, y1)
        
        a = a + 0.071
        b = b + 0.07
        
        co = co + 1
        if (co > 100) {
            co = 0
        }
    }
    
    // -------------------------------------------------------------------------
    
}
