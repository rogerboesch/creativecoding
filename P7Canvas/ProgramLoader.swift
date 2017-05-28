//
//  ProgramLoader.swift
//  P7Canvas
//
//  Created by Roger Boesch on 26.05.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class ProgramLoader {
    private static let _totalPrograms = 20
    private static var _currentProgram = 1
    
    // -------------------------------------------------------------------------
    // MARK: - Properties
    
    class var current: Int {
        get {
            return ProgramLoader._currentProgram
        }
    }
    
    // -------------------------------------------------------------------------
    
    class var total: Int {
        get {
            return ProgramLoader._totalPrograms
        }
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Activate program

    private class func instantiateProgram() -> P7Program {
        if ProgramLoader._currentProgram > ProgramLoader._totalPrograms {
            ProgramLoader._currentProgram = 1
        }
        else if ProgramLoader._currentProgram < 1 {
            ProgramLoader._currentProgram = ProgramLoader._totalPrograms
        }
        
        var program: P7Program?
        
        switch _currentProgram {
        case 1:
            program = Example1()
            break
        case 2:
            program = Example2()
            break
        case 3:
            program = Example3()
            break
        case 4:
            program = Example4()
            break
        case 5:
            program = Example5()
            break
        case 6:
            program = Example6()
            break
        case 7:
            program = Example7()
            break
        case 8:
            program = Example8()
            break
        case 9:
            program = Example9()
            break
        case 10:
            program = Example10()
            break
        case 11:
            program = Example11()
            break
        case 12:
            program = Example12()
            break
        case 13:
            program = Example13()
            break
        case 14:
            program = Example14()
            break
        case 15:
            program = Example15()
            break
        case 16:
            program = Example16()
            break
        case 17:
            program = Example17()
            break
        case 18:
            program = Example18()
            break
        case 19:
            program = Example19()
            break
        case 20:
            program = Example20()
            break
        default:
            print("Unknow program number. instantiateProgram() incomplete. Return Example 1 instead.")
            program = Example1()
        }
        
        return program!
    }

    // -------------------------------------------------------------------------
    // MARK: - Load programs

    class func loadFirstProgram() -> P7Program {
        ProgramLoader._currentProgram = 1
        return instantiateProgram()
    }
    
    // -------------------------------------------------------------------------
    
    class func loadPrevProgram() -> P7Program {
        ProgramLoader._currentProgram -= 1
        return instantiateProgram()
    }
    
    // -------------------------------------------------------------------------
    
    class func loadNextProgram() -> P7Program {
        ProgramLoader._currentProgram += 1
        return instantiateProgram()
    }
    
    // -------------------------------------------------------------------------

}
