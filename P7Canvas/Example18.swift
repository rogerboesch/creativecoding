//
//  Example18.swift
//  P7Canvas
//
//  Crazy Rings
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example18 : P7Program {
    
    var agitation: CGFloat = 0

    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Crazy Rings"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(OFF)
        p7size(p7width(), p7width())
        p7background(0)
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        setAgitation(p7map(p7touchX(), 0, p7width(), 0, 1))
        
        var phase = CGFloat(_frameRate) * 0.015
        var phaseAddition = p7map(sin(phase), -1, 1, 0, 0.75)
        
        for _ in 0...9 {
            let x = sin(phase)
            let radius = p7map(x, -1, 1, 40, 300)
            let lineWidth = p7map(x, -1, 1, 0, 5)
 
            var r = p7map(x, -1, 1, 0, 255)
            var g = p7map(x, -1, 1, 255, 0)
            var b = p7map(x, -1, 1, 255, 125)

            r = p7lerp(255, r, agitation)
            g = p7lerp(255, g, agitation)
            b = p7lerp(255, b, agitation)
            p7fill(Int(r), Int(g), Int(b))

            let lineWidthAddition = p7random(p7map(agitation, 0, 1, 0, 25))
            p7stroke(lineWidth + CGFloat(lineWidthAddition))
            p7fillMode(OFF)
            
            p7ellipse(p7width() / 2, p7height() / 2, radius, radius)
            phase = phase + phaseAddition
            phaseAddition += 0.1
        }
    }
    
    // -------------------------------------------------------------------------

    func setAgitation(_ newAgitation: CGFloat) {
        agitation = newAgitation
    }

    // -------------------------------------------------------------------------

}
