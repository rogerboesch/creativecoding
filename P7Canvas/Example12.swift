//
//  Example12.swift
//  P7Canvas
//
//  Star field
//  https://www.funprogramming.org/58-Travel-through-space-use-an-array-to-move-stars.html
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example12 : P7Program {
    private var xList = Array<CGFloat>()
    private var yList = Array<CGFloat>()
    private var speedList = Array<CGFloat>()
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Star Field"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        p7size(p7width(), p7width())
        p7background(0)
        
        var i = 0
        while (i < 100) {
            let x = p7random(0, p7width())
            let y = p7random(0, p7height())
            let speed = p7random(1, 5)
            
            xList.append(CGFloat(x))
            yList.append(CGFloat(y))
            speedList.append(CGFloat(speed))

            i = i + 1
        }
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        var i = 0
        while (i < 100) {
            let co = p7map(speedList[i], 1, 5, 100, 255)
            p7fill(Int(co))
            p7stroke(speedList[i])
            p7ellipse(xList[i], yList[i], speedList[i], speedList[i])
            
            xList[i] = xList[i] - speedList[i] / 2
            
            if(xList[i] < 0) {
                xList[i] = p7width()
            }
            
            i = i + 1
        }
    }
    
    // -------------------------------------------------------------------------
    
}
