//
//  Example15.swift
//  P7Canvas
//
//  Hypnosis
//  https://www.funprogramming.org/113-Array-of-objects-hypnotic-animation-part-II.html
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example15 : P7Program {
    private let MAX_BUGS = 200
    private var bugs = Array<Bug>()

    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Hypnosis"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        p7size(p7width(), p7width())
        p7background(152, 0, 0)
        p7fill(255)
        
        for i in 0...MAX_BUGS-1 {
            let x = p7width()/2 + CGFloat(cos(Double(i)/2.0) * Double(i))
            let y = p7height()/2 + CGFloat(sin(Double(i)/2.0) * Double(i))
            
            let bug = Bug(x, y, CGFloat(0.05 + (Double(i)/1000.0)))
            bugs.append(bug)
        }
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        for bug in bugs {
            bug.live()
        }
    }
    
    // -------------------------------------------------------------------------
    
}

class Bug {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var t: CGFloat = 0
    var speed: CGFloat = 0
    
    init(_ tx: CGFloat, _ ty: CGFloat, _ tspeed: CGFloat) {
        x = tx
        y = ty
        t = 0
        speed = tspeed
    }
    
    func live() {
        let sz = p7map(sin(t), -1, 1, 10, 20)
        p7ellipse(x, y, sz, sz)
        t = t + speed
    }
    
}
