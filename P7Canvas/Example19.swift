//
//  Example19.swift
//  P7Canvas
//
//  Additive Wave
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example19 : P7Program {
    private var xspacing: CGFloat = 8
    private var w: CGFloat = 0
    private var maxwaves: Int = 4
    private var theta: CGFloat = 0
    
    private var amplitude = Array<CGFloat>()
    private var dx = Array<CGFloat>()
    private var yvalues = Array<CGFloat>()

    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Additive Wave"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        p7size(p7width(), p7width())
        p7background(0)
        
        w = p7width() + CGFloat(16)
        
        for _ in 0...maxwaves-1 {
            let a = CGFloat(p7random(10, 30))
            amplitude.append(a)
            
            let period = CGFloat(p7random(100, 300))
            let p = CGFloat(Double.pi*2) / period * xspacing
            dx.append(p)
        }

        for _ in 1...Int(w/xspacing) {
            yvalues.append(0)
        }
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        calcWave()
        renderWave()
    }
    
    // -------------------------------------------------------------------------
    
    func calcWave() {
        theta += 0.02;

        // Set all height values to zero
        for i in 0...yvalues.count-1 {
            yvalues[i] = 0
        }

        // Accumulate wave height values
        for j in 0...maxwaves-1 {
            var x = theta

            for i in 0...yvalues.count-1 {
                // Every other wave is cosine instead of sine
                if (j % 2 == 0) {
                    yvalues[i] += sin(x)*amplitude[j]
                }
                else {
                    yvalues[i] += cos(x)*amplitude[j]
                }
                
                x += dx[j]
            }
        }
    }
    // -------------------------------------------------------------------------
    
    func renderWave() {
        p7fill(255, 50, 0)

        for x in 0...yvalues.count-1 {
            p7ellipse(CGFloat(x)*xspacing, p7height()/2+yvalues[x], 16, 16)
        }
    }
    
    // -------------------------------------------------------------------------
    
}
