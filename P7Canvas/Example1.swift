//
//  Example1.swift
//  P7Canvas
//
//  Bouncing ball: Adapted from processing tutorial to Swift
//  https://www.toptal.com/game/ultimate-guide-to-processing-simple-game
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example1 : P7Program {

    var gravity: CGFloat = 1
    var airfriction: CGFloat = 0.0001
    var friction: CGFloat = 0.1
    var ballSpeedVert: CGFloat = 0
    var ballX: CGFloat = 0
    var ballY: CGFloat = 0
    var ballSize: CGFloat = 20
    var ballColor = Color(255, 0, 0)

    var a: CGFloat = 0

    let MAX_TAIL = 30
    var tail = Array<CGPoint>()

    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Bouncing Ball"
    }

    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        
        p7size(p7width(), p7width())
        
        ballX = p7width() / 2
        ballY = p7height() / 5
        ballSpeedVert = 0
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        p7background(255)
        
        handleTail()

        applyGravity()
        keepInScreen()
        
        drawBall()
    }
    
    // -------------------------------------------------------------------------
    
    func gameScreen() {
        p7background(255)
        
        applyGravity()
        keepInScreen()
        
        drawBall()
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Ball
    
    func drawBall() {
        p7fill(ballColor)
        p7ellipse(ballX, ballY, ballSize, ballSize)
    }
    
    // -------------------------------------------------------------------------
    
    func applyGravity() {
        ballSpeedVert += gravity
        ballY += ballSpeedVert
        
        ballSpeedVert -= (ballSpeedVert * airfriction)
    }
    
    // -------------------------------------------------------------------------
    
    func makeBounceBottom(_ surface: CGFloat) {
        ballY = surface - (ballSize/2)
        ballSpeedVert *= -1
        
        ballSpeedVert -= (ballSpeedVert * friction)
    }
    
    // -------------------------------------------------------------------------
    
    func makeBounceTop(_ surface: CGFloat) {
        ballY = surface + (ballSize/2)
        ballSpeedVert *= -1
        
        ballSpeedVert -= (ballSpeedVert * friction)
    }
    
    // -------------------------------------------------------------------------
    
    func keepInScreen() {
        // ball hits floor
        if (ballY+(ballSize/2) > p7height()) {
            makeBounceBottom(p7height())
        }
        
        // ball hits ceiling
        if (ballY-(ballSize/2) < 0) {
            makeBounceTop(0)
        }
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Tail
    
    func handleTail() {
        tail.insert(CGPoint(x: ballX, y: ballY), at: 0)
        
        if tail.count > MAX_TAIL {
            tail.removeLast()
        }
        
        var index = 0
        for element in tail {
            let color = 255 / MAX_TAIL * index
            p7fill(Color(color))
            p7alpha(255-color)
            
            p7ellipse(element.x, element.y, ballSize-CGFloat(index), ballSize-CGFloat(index))
            
            index += 1
        }
        
        p7alpha(255)
    }

    // -------------------------------------------------------------------------

}
