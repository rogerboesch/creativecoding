//
//  AppViewController.swift
//  P7Canvas
//
//  Created by Roger Boesch on 24.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
    private var _canvas = P7Canvas(frame: CGRect.zero)
    private var _lastTime: TimeInterval = 0
    private var _renderTime: TimeInterval = 1.0 / 60.0
    private var _timer: Timer?
    private let _buttonPrev = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
    private let _buttonNext = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
    private let _infoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
    
    // -------------------------------------------------------------------------
    // MARK: - Navigate buttons
    
    private func updateInfo() {
        var name = ""
        if P7Canvas.program != nil {
            name = P7Canvas.program!.name()
        }

        let str = "\(name) - \(ProgramLoader.current) of \(ProgramLoader.total)"
        _infoLabel.text = str
    }
    
    // -------------------------------------------------------------------------
    
    func prev(_ sender: Any) {
        let program = ProgramLoader.loadPrevProgram()
        P7Canvas.program = program
        updateInfo()
    }
    
    // -------------------------------------------------------------------------
    
    func next(_ sender: Any) {
        let program = ProgramLoader.loadNextProgram()
        P7Canvas.program = program
        updateInfo()
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Draw loop
    
    func renderLoop() {
        _canvas.renderStep()

        _renderTime = 1.0 / Double(_frameRate)

        _lastTime = CFAbsoluteTimeGetCurrent()
        _timer = Timer.scheduledTimer(timeInterval: _renderTime, target: self, selector: #selector(renderLoop), userInfo: nil, repeats: false)
    }

    // -------------------------------------------------------------------------
    // MARK: - View life cycle
    
    override func viewDidLayoutSubviews() {
        _canvas.frame = self.view.bounds
        
        _canvas.start(self.view)
        
        var rect = _buttonPrev.frame
        rect.origin.x = 0
        rect.origin.y = self.view.bounds.size.width + 40
        rect.size.width = self.view.bounds.size.width / 2 - 2
        _buttonPrev.frame = rect
        
        rect = _buttonNext.frame
        rect.origin.x = self.view.bounds.size.width / 2 + 2
        rect.origin.y = self.view.bounds.size.width + 40
        rect.size.width = self.view.bounds.size.width / 2 - 2
        _buttonNext.frame = rect

        rect.origin.x = 0
        rect.origin.y = self.view.bounds.size.width + 80
        rect.size.width = self.view.bounds.size.width
        rect.size.height = 40
        _infoLabel.frame = rect
        
    }

    // -------------------------------------------------------------------------

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _lastTime = CFAbsoluteTimeGetCurrent()
        _timer = Timer.scheduledTimer(timeInterval: _renderTime, target: self, selector: #selector(renderLoop), userInfo: nil, repeats: false)

        let program = ProgramLoader.loadFirstProgram()
        P7Canvas.program = program
        updateInfo()
    }
    
    // -------------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // -------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1.0)
        self.view.addSubview(_canvas)
        _canvas.isUserInteractionEnabled = true
        
        self.view.addSubview(_buttonPrev)
        _buttonPrev.setTitle("<<", for: .normal)
        _buttonPrev.addTarget(self, action: #selector(prev(_:)), for: .touchUpInside)
        _buttonPrev.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        self.view.addSubview(_buttonNext)
        _buttonNext.setTitle(">>", for: .normal)
        _buttonNext.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
        _buttonNext.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        self.view.addSubview(_infoLabel)
        _infoLabel.textAlignment = .center
        _infoLabel.textColor = UIColor.white
        _infoLabel.font = UIFont.systemFont(ofSize: 12)
    }

    // -------------------------------------------------------------------------

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // -------------------------------------------------------------------------

}

