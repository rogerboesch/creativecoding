//
//  P7Input.swift
//  P7Canvas - Touch/Input handling
//
//  Created by Roger Boesch on 24.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import UIKit

// -----------------------------------------------------------------------------
// MARK: - Touch handling

public func p7touchPoint() -> CGPoint {
    return _touchPoint
}

// -----------------------------------------------------------------------------

public func p7touchX() -> CGFloat {
    return _touchPoint.x
}

// -----------------------------------------------------------------------------

public func p7touchY() -> CGFloat {
    return _touchPoint.y
}

// -----------------------------------------------------------------------------

public func p7ptouchX() -> CGFloat {
    return _touchPointPrevious.x
}

// -----------------------------------------------------------------------------

public func p7ptouchY() -> CGFloat {
    return _touchPointPrevious.y
}

// -----------------------------------------------------------------------------

public func p7touched() -> Bool {
    return _touched
}

// -----------------------------------------------------------------------------
