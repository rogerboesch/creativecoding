//
//  Example2.swift
//  P7Canvas
//
//  Simple padle: Adapted from processing tutorial to Swift
//  https://www.toptal.com/game/ultimate-guide-to-processing-simple-game
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example2 : P7Program {
    
    var currentScreen: Int = 0
    var gravity: CGFloat = 1
    var airfriction: CGFloat = 0.0001
    var friction: CGFloat = 0.1
    
    var ballSpeedVert: CGFloat = 0
    var ballX: CGFloat = 0
    var ballY: CGFloat = 0
    var ballSize: CGFloat = 20
    var ballColor = Color(255, 0, 0)
    var ballSpeedHorizon: CGFloat = 10
    
    var racketColor = Color(0)
    var racketWidth: CGFloat = 100
    var racketHeight: CGFloat = 10
    var racketBounceRate = 20
    var racketX: CGFloat = 0
    var racketY: CGFloat = 0
    
    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Simple Padle"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(ON)
        
        p7size(p7width(), p7width())
        ballX = p7width() / 2
        ballY = p7height() / 5
        ballSpeedVert = 0
        
        racketX = p7width() / 2
        racketY = p7height() / 5 * 4
    }
    
    // -------------------------------------------------------------------------
    
    func draw() {
        p7background(255)
        
        applyGravity()
        keepInScreen()
        applyHorizontalSpeed()
        drawBall()

        if _touched {
            racketX = p7touchX()
            racketY = p7touchY()
        }
        
        watchRacketBounce()
        drawRacket()
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Rocket
    
    func watchRacketBounce() {
        let overhead: CGFloat = p7touchY() - p7ptouchY()
        
        if ((ballX+(ballSize/2) > racketX-(racketWidth/2)) && (ballX-(ballSize/2) < racketX+(racketWidth/2))) {
            if p7dist(ballX, ballY, ballX, racketY) <= (ballSize/2)+abs(overhead) {
                makeBounceBottom(racketY)
                
                ballSpeedHorizon = (ballX - racketX) / 40
                
                // racket moving up
                if (overhead < 0) {
                    ballY += overhead
                    ballSpeedVert += overhead
                }
            }
        }
    }
    
    // -------------------------------------------------------------------------
    
    func drawRacket() {
        p7fill(racketColor)
        p7rect(racketX, racketY, racketWidth, racketHeight)
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
    
    func applyHorizontalSpeed() {
        ballX += ballSpeedHorizon
        ballSpeedHorizon -= (ballSpeedHorizon * airfriction)
    }
    
    // -------------------------------------------------------------------------
    
    func makeBounceLeft(_ surface: CGFloat) {
        ballX = surface + (ballSize/2)
        ballSpeedHorizon *= -1
        ballSpeedHorizon -= (ballSpeedHorizon * friction)
    }
    
    // -------------------------------------------------------------------------
    
    func makeBounceRight(_ surface: CGFloat) {
        ballX = surface - (ballSize/2)
        ballSpeedHorizon *= -1
        ballSpeedHorizon -= (ballSpeedHorizon * friction)
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
        
        if ballX-(ballSize/2) < 0 {
            makeBounceLeft(0)
        }
        
        if ballX+(ballSize/2) > p7width() {
            makeBounceRight(p7width())
        }
    }
    
    // -------------------------------------------------------------------------
    
}
