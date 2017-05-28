//
//  P7Pixel.swift
//  P7Canvas
//
//  Created by Roger Boesch on 27.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import UIKit

// Format is RGBA
private let BYTES_PER_PIXEL = 4

// -----------------------------------------------------------------------------
// MARK: - Public pixel buffer methods

func p7loadPixels() {
    guard _canvas != nil else { return }
    
    return _canvas!.loadPixels()
}

// -----------------------------------------------------------------------------

func p7updatePixels() {
    guard _canvas != nil else { return }
    
    return _canvas!.updatePixels()
}

// -----------------------------------------------------------------------------

func p7pixelAt(_ x: Int, _ y: Int) -> Color {
    guard _pixelBuffer != nil else { return Color(0) }

    let offset = pixelOffset(x, y)
    
    let r = _pixelBuffer![offset]
    let g = _pixelBuffer![offset+1]
    let b = _pixelBuffer![offset+2]
    let a = _pixelBuffer![offset+3]
    
    let color = Color(Int(r), Int(g), Int(b), Int(a))

    return color
}

// -----------------------------------------------------------------------------

func p7setPixelAt(_ x: Int, _ y: Int, _ color: Color) {
    guard _pixelBuffer != nil else { return }

    let offset = pixelOffset(x, y)

    _pixelBuffer![offset] = UInt8(color.r)
    _pixelBuffer![offset+1] = UInt8(color.g)
    _pixelBuffer![offset+2] = UInt8(color.b)
    _pixelBuffer![offset+3] = UInt8(color.a)
}

// -----------------------------------------------------------------------------
// MARK: - Private pixel buffer methods

private func pixelOffset(_ x: Int, _ y: Int) -> Int {
    var offset = x + (y * Int(_pixelBufferWidth))
    offset *= BYTES_PER_PIXEL
    
    return offset
}

// -----------------------------------------------------------------------------

private func lastPixelOffset() -> Int {
    let x = _pixelBufferWidth-1
    let y = _pixelBufferHeight-1
    
    let offset = x + (y * Int(_pixelBufferWidth))
    return offset
}

// -----------------------------------------------------------------------------

func pixelValues(fromCGImage imageRef: CGImage?) -> (pixelValues: [UInt8]?, width: Int, height: Int) {
    var width = 0
    var height = 0
    var pixelValues: [UInt8]?
    
    if let imageRef = imageRef {
        width = imageRef.width
        height = imageRef.height
        let bitsPerComponent = imageRef.bitsPerComponent
        let bytesPerRow = BYTES_PER_PIXEL * Int(width)
        let totalBytes = height * bytesPerRow
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var intensities = [UInt8](repeating: 255, count: totalBytes)
        
        let contextRef = CGContext(data: &intensities, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        contextRef?.draw(imageRef, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))
        
        pixelValues = intensities
    }
    
    return (pixelValues, width, height)
}

// -----------------------------------------------------------------------------

func imageFromPixelValues(_ pixelValues: [UInt8]?, width: Int, height: Int) -> CGImage? {
    var imageRef: CGImage?
    
    if var pixelValues = pixelValues {
        let bitsPerComponent = 8
        let bitsPerPixel = BYTES_PER_PIXEL * bitsPerComponent
        let bytesPerRow = BYTES_PER_PIXEL * width
        let totalBytes = height * bytesPerRow
        
        imageRef = withUnsafePointer(to: &pixelValues, {
            ptr -> CGImage? in
            var imageRef: CGImage?
            let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue).union(CGBitmapInfo())
            let data = UnsafeRawPointer(ptr.pointee).assumingMemoryBound(to: UInt8.self)
            let releaseData: CGDataProviderReleaseDataCallback = {
                (info: UnsafeMutableRawPointer?, data: UnsafeRawPointer, size: Int) -> () in
            }
            
            if let providerRef = CGDataProvider(dataInfo: nil, data: data, size: totalBytes, releaseData: releaseData) {
                imageRef = CGImage(width: width,
                                   height: height,
                                   bitsPerComponent: bitsPerComponent,
                                   bitsPerPixel: bitsPerPixel,
                                   bytesPerRow: bytesPerRow,
                                   space: colorSpaceRef,
                                   bitmapInfo: bitmapInfo,
                                   provider: providerRef,
                                   decode: nil,
                                   shouldInterpolate: false,
                                   intent: CGColorRenderingIntent.defaultIntent)
            }
            
            return imageRef
        })
    }
    
    return imageRef
}

// -----------------------------------------------------------------------------
