//
//  Example16.swift
//  P7Canvas
//
//  Particles
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example16 : P7Program {

    private let MAX_DOTS = 100
    private var dots = Array<Dot>()
    private var color = Color(0)
    private var diameter: CGFloat = 6.0

    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Particles"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        p7size(p7width(), p7width())
        p7background(0)
        p7fill(255, 0, 0)
 
        for _ in 0...MAX_DOTS-1 {
            let dot = Dot()
            dot.x = p7randomF(p7width())
            dot.y = p7randomF(p7height())
            dot.vx = p7randomF(2.0) - CGFloat(1.0)
            dot.vy = p7randomF(2.0) - CGFloat(1.0)
            
            dots.append(dot)
        }
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        for i in 0...MAX_DOTS-1 {
            let dot = dots[i]
            
            let r = p7map(dot.x, 0, p7width(), 0, 255)
            let g = p7map(dot.y, 0, p7height(), 0, 255)
            let b = 255
            
            p7fill(Int(r), Int(g), Int(b))
            dot.update()
            p7ellipse(dot.x, dot.y, diameter, diameter)

            dots[i] = dot
        }
    }
    
    // -------------------------------------------------------------------------
    
}

private class Dot {
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var vx: CGFloat = 0.0
    var vy: CGFloat = 0.0
    
    func update() {
        // update the velocity
        self.vx += p7randomF(2.0) - 1.0
        self.vx *= 0.96
        self.vy += p7randomF(2.0) - 1.0
        self.vy *= 0.96
        
        // update the position
        self.x += self.vx
        self.y += self.vy
        
        // handle boundary collision
        if (self.x > p7width()) {
            self.x = p7width()
            self.vx *= -1.0
        }
        
        if (self.x < 0) {
            self.x = 0
            self.vx *= -1.0
        }
        
        if (self.y > p7height()) {
            self.y = p7height()
            self.vy *= -1.0
        }
        
        if (self.y < 0) {
            self.y = 0
            self.vy *= -1.0
        }
    }
}
