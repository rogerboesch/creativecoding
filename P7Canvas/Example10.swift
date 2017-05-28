//
//  Example10.swift
//  P7Canvas
//
//  Random Walk
//  http://www.creativecoding.org/example/simulation:brownsche-irrfahrt
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example10 : P7Program {
    
    let NUM = 50
    var pos = Array<Vector>()
    var col = Array<Color>()
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Random Walk"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7size(p7width(), p7width())
        
        p7background(79)
        p7clearMode(OFF)
        p7rectMode(CENTER)
        
        p7frameRate(1000)
        
        // For each point
        for _ in 0...NUM-1 {
            let vector = Vector(x: CGFloat(p7random(p7width())), y: CGFloat(p7random(p7height())))
            pos.append(vector)
            
            let color = Color(p7random(90, 250), 170, 178)
            col.append(color)
        }
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        for i in 0...NUM-1 {
            pos[i].x += CGFloat(p7random (-1, 1))
            pos[i].y += CGFloat(p7random (-1, 1))
            
            // Left
            if (pos[i].x < 0) {
                pos[i].x = 0
            }
            
            // Right
            if pos[i].x > p7width() {
                pos[i].x = p7width()
            }
            
            // Top
            if pos[i].y < 0 {
                pos[i].y = 0
            }
            
            // Bottom
            if pos[i].y > p7height() {
                pos[i].y = p7height()
            }
            
            p7fill(col[i])
            p7rect(pos[i].x, pos[i].y, 1, 1)
        }
    }
    
    // -------------------------------------------------------------------------

}
