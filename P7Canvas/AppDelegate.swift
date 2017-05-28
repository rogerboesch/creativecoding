//
//  AppDelegate.swift
//  P7Canvas
//
//  Created by Roger Boesch on 24.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var _window: UIWindow?
    private var _viewController: AppViewController?
    
    // -------------------------------------------------------------------------
    // MARK: - Application life cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        _viewController = AppViewController()
        
        _window = UIWindow(frame: UIScreen.main.bounds)
        _window?.rootViewController = _viewController
        _window?.makeKeyAndVisible()
        
        return true
    }

    // -------------------------------------------------------------------------

}

