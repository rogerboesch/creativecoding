//
//  Example7.swift
//  P7Canvas
//
//  Polar cartesian, 13-05
//  http://learningprocessing.com/examples/chp13/example-13-05-polar-cartesian
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example7 : P7Program {
    
    var r1: CGFloat = 160
    var r2: CGFloat = 120
    var r3: CGFloat = 80
    var r4: CGFloat = 40

    var theta: CGFloat = 0
    var theta_vel: CGFloat = 0
    var theta_acc: CGFloat = 0.0001
    
    let MAX_TAIL = 30
    var tail1 = Array<CGPoint>()
    var tail2 = Array<CGPoint>()
    var tail3 = Array<CGPoint>()
    var tail4 = Array<CGPoint>()

    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Polar to Cartesian"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7size(p7width(), p7width())
        
        p7background(255)
        p7clearMode(ON)
        p7rectMode(CENTER)
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        p7background(255)
        
        // Polar to Cartesian conversion
        let x1 = r1 * cos(theta)
        let y1 = r1 * sin(theta)
        let x2 = r2 * cos(-theta)
        let y2 = r2 * sin(-theta)
        let x3 = r3 * cos(theta)
        let y3 = r3 * sin(theta)
        let x4 = r4 * cos(-theta)
        let y4 = r4 * sin(-theta)
        
        p7noStroke()
        
        // Adjust for center of window
        p7fill(0)
        p7ellipse(x1 + p7width()/2, y1 + p7height()/2, 24, 24)
        handleTail(number: 1, x: x1 + p7width()/2, y: y1 + p7height()/2)
        drawTail(number: 1)
        
        //p7fill(255, 0, 0)
        p7ellipse(x2 + p7width()/2, y2 + p7height()/2, 24, 24)
        handleTail(number: 2, x: x2 + p7width()/2, y: y2 + p7height()/2)
        drawTail(number: 2)
        
        //p7fill(0, 255, 0)
        p7ellipse(x3 + p7width()/2, y3 + p7height()/2, 24, 24)
        handleTail(number: 3, x: x3 + p7width()/2, y: y3 + p7height()/2)
        drawTail(number: 3)
        
        //p7fill(0, 0, 255)
        p7ellipse(x4 + p7width()/2, y4 + p7height()/2, 24, 24)
        handleTail(number: 4, x: x4 + p7width()/2, y: y4 + p7height()/2)
        drawTail(number: 4)
        
        // Increment the angle
        theta_vel += theta_acc
        theta += theta_vel
    }
        
    // -------------------------------------------------------------------------
    // MARK: - Tail

    func drawTail(number: Int) {
        var tail: Array<CGPoint> = tail1
        
        if number == 2 {
            tail = tail2
        }
        else if number == 3 {
            tail = tail3
        }
        else if number == 4 {
            tail = tail4
        }
        
        var index = 0
        for element in tail {
            let color = 255 / MAX_TAIL * index
            
            if number == 1 {
                p7fill(Color(color, color, 0))
            }
            else if number == 2 {
                p7fill(Color(color, 0, 0))
            }
            else if number == 3 {
                p7fill(Color(0, color, 0))
            }
            else if number == 4 {
                p7fill(Color(0, 0, color))
            }

            p7alpha(255-color)
            
            p7ellipse(element.x, element.y, 24-CGFloat(index), 24-CGFloat(index))
            
            index += 1
        }
        
        p7alpha(255)
    }

    // -------------------------------------------------------------------------

    func handleTail(number: Int, x: CGFloat, y: CGFloat) {
        if number == 1 {
            tail1.insert(CGPoint(x: x, y: y), at: 0)
            
            if tail1.count > MAX_TAIL {
                tail1.removeLast()
            }
        }
        else if number == 2 {
            tail2.insert(CGPoint(x: x, y: y), at: 0)
            
            if tail2.count > MAX_TAIL {
                tail2.removeLast()
            }
        }
        else if number == 3 {
            tail3.insert(CGPoint(x: x, y: y), at: 0)
            
            if tail3.count > MAX_TAIL {
                tail3.removeLast()
            }
        }
        else if number == 4 {
            tail4.insert(CGPoint(x: x, y: y), at: 0)
            
            if tail4.count > MAX_TAIL {
                tail4.removeLast()
            }
        }
    }
    
}
