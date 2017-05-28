//
//  Example3.swift
//  P7Canvas
//
//  Falling Sand: Access the pixel buffer
//
//  Created by Roger Boesch on 24.05.17.
//

import UIKit

class Example3 : P7Program {
    
    private let background = Color(255)
    private var fillColor = Color(0)
    private var count: Int = 0

    // -------------------------------------------------------------------------
    // MARK: - Get program info
    
    func name() -> String {
        return "Falling Sand"
    }
    
    // -------------------------------------------------------------------------
    // MARK: - P7 calls
    
    func setup() {
        p7clearMode(OFF)
        
        p7size(p7width(), p7width())
        
        p7frameRate(1000)
    }

    
    // -------------------------------------------------------------------------
    
    func draw() {
        p7background(255)

        let width = Int(p7width())
        let height = Int(p7height())

        p7loadPixels()
        
        // Let sand fall
        var h = height - 1
        while (h >= 0) {
            var w = 0
            
            while (w < width) {
                if h < height-1 {
                    // Move down if empty
                    if p7pixelAt(w, h) != background {
                        let color = p7pixelAt(w, h)
                        
                        if p7pixelAt(w, h+1) == background {
                            p7setPixelAt(w, h, background)
                            p7setPixelAt(w, h+1, color)
                        }
                        else if w > 0 && w < width-1 {
                            if p7pixelAt(w-1, h+1) == background && p7pixelAt(w+1, h+1) == background {
                                // If left and right is empty choose by random
                                if (p7random(1, 2) == 1) {
                                    // Move left if empty
                                    p7setPixelAt(w, h, background)
                                    p7setPixelAt(w-1, h+1, color)
                                }
                                else {
                                    // Move right if empty
                                    p7setPixelAt(w, h, background)
                                    p7setPixelAt(w+1, h+1, color)
                                }
                            }
                            else if p7pixelAt(w-1, h+1) == background {
                                // Move left if empty
                                p7setPixelAt(w, h, background)
                                p7setPixelAt(w-1, h+1, color)
                            }
                            else if p7pixelAt(w+1, h+1) == background {
                                // Move right if empty
                                p7setPixelAt(w, h, background)
                                p7setPixelAt(w+1, h+1, color)
                            }
                        }
                    }
                }
                
                w += 1
            }
            
            h -= 1
        }
        
        if count >= 0 && count < 100 {
            // Sand
            fillColor = Color(240, 209, 155)

            for i in 0...width-1 {
                if (p7random(1, 20) <= 2) {
                    p7setPixelAt(i, 0, fillColor)
                }
            }
        }
        else if count >= 100 && count < 300 {
            // Grass
            fillColor = Color(122, 205, 115)
            
            let half = width/2
            for i in half-100...half+100 {
                if (p7random(1, 20) <= 2) {
                    p7setPixelAt(i, 0, fillColor)
                }
            }
        }
        else if count >= 300 && count < 400 {
            // Water
            fillColor = Color(74, 179, 198)
            
            for i in 0...width-1 {
                if (p7random(1, 20) <= 2) {
                    p7setPixelAt(i, 0, fillColor)
                }
            }
        }
        else {
            count = 0
        }
        
        count += 1
        
        p7updatePixels();
       
    }
    
    // -------------------------------------------------------------------------
    
    func lin(_ x: Int, _ y: Int) -> Int {
        return x + (y * Int(p7width()))
    }

    // -------------------------------------------------------------------------

}
