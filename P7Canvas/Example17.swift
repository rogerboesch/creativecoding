//
//  Example17.swift
//  P7Canvas
//
//  Blobs
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example17 : P7Program {
    
    private let MAX_BLOBS = 30
    private var blobs = Array<Blob>()
    private var targetX: CGFloat = 0
    private var targetY: CGFloat = 0
    private var state = 0
    
    var rot: CGFloat = 0
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Blobs"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        p7size(p7width(), p7width())
        p7background(0)
        
        for _ in 0...MAX_BLOBS-1 {
            let blob = Blob()
            
            blob.x = p7randomF(p7width())
            blob.y = p7randomF(p7height())
            blob.sx = blob.x
            blob.sy = blob.y
            blob.easingX = 0.02 + p7randomF(0.10)
            blob.easingY = 0.02 + p7randomF(0.10)
            blob.strokeSize = 10 + p7randomF(60)
            blob.fillSize = blob.strokeSize - 10.0
            
            blobs.append(blob)
        }
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        p7background(0)

        if _touched {
            if state == 0 {
                state = 1
                
                targetX = p7touchX()
                targetY = p7touchY()
                
                _touched = false
            }
            else if state == 1 {
                state = 2
                
                _touched = false
            }
            else if state == 2 {
                state = 1
                
                targetX = p7touchX()
                targetY = p7touchY()
                
                _touched = false
            }
        }

        p7fill(255, 0, 170)
        
        for i in 0...MAX_BLOBS-1 {
            let blob = blobs[i]
            
            if state == 1 {
                blob.springToward(targetX, targetY)
            }
            else if state == 2 {
                blob.springToward(blob.sx, blob.sy)
            }
            
            blob.renderStroke()
            
            blobs[i] = blob
        }
        
        p7fill(170, 255, 1)
        
        for i in 0...MAX_BLOBS-1 {
            let blob = blobs[i]
            blob.renderFill()
        }
    }
    
    // -------------------------------------------------------------------------
    
}

class Blob {
    var sx: CGFloat = 0.0
    var sy: CGFloat = 0.0
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var vx: CGFloat = 0.0
    var vy: CGFloat = 0.0
    var easingX: CGFloat = 0.0
    var easingY: CGFloat = 0.0
    var strokeSize: CGFloat = 20.0
    var fillSize: CGFloat = 10.0
    
    func renderStroke() {
        p7ellipse(self.x, self.y, self.strokeSize, self.strokeSize)
    }
    
    func renderFill() {
        p7ellipse(self.x, self.y, self.fillSize, self.fillSize)
    }
    
    func springToward(_ x: CGFloat, _ y: CGFloat) {
        self.vx += (x - self.x) * self.easingX
        self.vy += (y - self.y) * self.easingY
        self.vx *= 0.92
        self.vy *= 0.90
        self.x += self.vx
        self.y += self.vy
    }
}
