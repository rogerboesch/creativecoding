//
//  Example20.swift
//  P7Canvas
//
//  Distance 2D
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example20 : P7Program {
    
    private var max_distance: CGFloat = 0
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Distance 2D"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        p7size(p7width(), p7width())
        p7background(0)
        p7fill(255)
        
        _touchPoint = CGPoint(x: p7width()/2, y:p7height()/2)
        max_distance = p7dist(0, 0, p7width(), p7height())
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {

        var i: CGFloat = 0
        while (i <= p7width()) {
            i += 20

            var j: CGFloat = 0
            while (j <= p7height()) {
                var size = p7dist(p7touchX(), p7touchY(), i, j);
                size = size/max_distance * 66;
                p7ellipse(i, j, size, size);

                j += 20
            }
        }
    }
    
    // -------------------------------------------------------------------------
    
}
