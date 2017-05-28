//
//  P7Canvas.swift
//  P7Canvas
//
//  Created by Roger Boesch on 24.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import UIKit

private var _allowPixelAccess = false

public protocol P7Program {
    func setup()
    func draw()
    
    func name() -> String
}

public class P7Canvas : UIImageView {
    private var _renderedImage: UIImage?
    private static var _program: P7Program?
    
    // -------------------------------------------------------------------------
    // MARK: - Program handling

    static var program: P7Program? {
        get {
            return _program
        }
        set(value) {
            if _canvas != nil {
                _canvas!.reset()
            }
            
            _program = value
            
            if _program != nil {
                _program!.setup()
            }
        }
    }

    // -------------------------------------------------------------------------

    func reset() {
        _frameRate = 60
        
        _renderedImage = nil
        _touched = false
        _touchPoint = CGPoint.zero
        _touchPointPrevious = CGPoint.zero
        _clearMode = OFF
        _colorMode = RGB
        
        _rectMode = CENTER
        _strokeCap = NORMAL
        _strokeWidth = 1
        
        _fillMode = ON
        _fillColor = Color(0, 0, 0)
        _alphaState = 255
        
        _textAlign = LEFT
        _textSize = 14
        _textFont = UIFont.systemFont(ofSize: 14)
    }

    // -------------------------------------------------------------------------
    // MARK: - Touch handling
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            _touched = true
            _touchPoint = touch.location(in: self)
        }
    }

    // -------------------------------------------------------------------------

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            _touchPoint = touch.location(in: self)
        }
    }

    // -------------------------------------------------------------------------

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            _touched = false
            _touchPoint = touch.location(in: self)
        }
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Initialization stage

    func start(_ view: UIView) {
        _canvas = self
        _view = view
        
        if P7Canvas.program != nil {
            P7Canvas.program?.setup()
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Render stage

    func renderStep() {
        UIGraphicsBeginImageContext(self.bounds.size)
        _context = UIGraphicsGetCurrentContext()

        // Draw previous frame (if clear mode is OFF)
        if _renderedImage != nil && _clearMode == OFF {
            _renderedImage!.draw(at: CGPoint.zero)
        }
        
        // Drawing code
        if P7Canvas.program != nil {
            P7Canvas.program?.draw()
        }
        else {
            p7background(0)
            p7textAlign(CENTER)
            p7fill(255)
            p7text("No P7 program to process", p7height()/2, p7width()/2)
        }
        
        // Save last touch point
        _touchPointPrevious = _touchPoint
        
        // Check if pixel access is active
        if _allowPixelAccess {
            unloadPixels()
        }
        else {
            // Get image
            _renderedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        // Display rendered image
        DispatchQueue.main.async {
            self.image = self._renderedImage
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Pixel buffer manipulation
    
    func updatePixels() {
        guard _allowPixelAccess == true else { return }
        
        unloadPixels()

        UIGraphicsBeginImageContext(self.bounds.size)
        _context = UIGraphicsGetCurrentContext()
        _renderedImage!.draw(at: CGPoint.zero)
    }
    
    // -------------------------------------------------------------------------

    func loadPixels() {
        guard _allowPixelAccess == false else { return }
        
        // Get image
        _renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        (_pixelBuffer, _pixelBufferWidth, _pixelBufferHeight) = pixelValues(fromCGImage: _renderedImage?.cgImage)

        _allowPixelAccess = true
    }

    // -------------------------------------------------------------------------

    private func unloadPixels() {
        guard _pixelBuffer != nil else { return }

        if let cgImage = imageFromPixelValues(_pixelBuffer!, width: _pixelBufferWidth, height: _pixelBufferHeight) {
            _renderedImage = UIImage(cgImage: cgImage)
        }
        else {
            print("ERROR")
        }
        
        _pixelBuffer = nil
        _pixelBufferHeight = 0
        _pixelBufferWidth = 0
        _allowPixelAccess = false
    }

}

// -----------------------------------------------------------------------------
// MARK: - Frame rate

func p7frameRate(_ rate: Int) {
    _frameRate = rate
}

// -----------------------------------------------------------------------------
// MARK: - Clear mode

func p7clearMode(_ mode: Int) {
    _clearMode = mode
}

// -----------------------------------------------------------------------------
// MARK: - Dimensions

func p7size(_ width: Int, _ height: Int) {
    p7size(CGFloat(width), CGFloat(height))
}

// -----------------------------------------------------------------------------

func p7size(_ width: CGFloat, _ height: CGFloat) {
    guard _canvas != nil && _view != nil else { return }
    
    let x: CGFloat = (_view!.bounds.size.width - CGFloat(width)) / 2
    let y: CGFloat = 0
    
    _canvas!.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
}

// -----------------------------------------------------------------------------

func p7height() -> CGFloat {
    guard _canvas != nil else { return 0 }

    return _canvas!.bounds.size.height
}

// -----------------------------------------------------------------------------

func p7width() -> CGFloat {
    guard _canvas != nil else { return 0 }
    
    return _canvas!.bounds.size.width
}

// -----------------------------------------------------------------------------
