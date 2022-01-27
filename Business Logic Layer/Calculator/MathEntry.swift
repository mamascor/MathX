//
//  MathEntry.swift
//  Calc
//
//  Created by Matthew Paul Harding on 26/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏼 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💚 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's a Data Access Manager, a simple wrapper for User Defaults.
//   💡 Architecture Tip 👉🏻 Used to disconnect how we store the data from anywhere else.
// *******************************************************************************************


import Foundation

struct MathEntry {
    
    // MARK: - Operation Side Enum
    enum OperationSide {
        case leftHandSide
        case rightHandSide
    }
    
    // MARK: - Constants
    let decimalSymbol = Locale.current.decimalSeparator ?? "."
    
    // MARK: - variables
    var equation: MathEquation = MathEquation()
    var editingSide: OperationSide = .leftHandSide
    var isEnteringDecimal: Bool = false
    var lcdDisplayString: String? // Tracking the string input from user
    
    init() {
        // Note: We create the equation with a value of 0, however the user did not enter this value
        // Therefore, we should reflect the value stored with our string representation
        lcdDisplayString = equation.lhs.formatted()
    }
    
    var isCompleted: Bool {
        return equation.executed
    }
    
    var isReadyToExecute: Bool {
        guard equation.executed == false else {
            return false
        }
        
        if let _ = equation.operation,
           let _ = equation.rhs {
            return true
        }
        
        return false
    }
    
    var decimalRepresentationOfEditingOperand: Decimal {
        switch editingSide {
        case .leftHandSide:
            return equation.lhs
        case .rightHandSide:
            return equation.rhs ?? 0
        }
    }
    
    // MARK: - Extra Functions
    mutating func negate() {
        guard isCompleted == false else { return }
        
        switch editingSide {
        case .leftHandSide:
            equation.lhs.negate()
        case .rightHandSide:
            equation.rhs?.negate()
        }
    }
    
    mutating func applyPercentage() {
        guard isCompleted == false else { return }
        
        let calculatePercentageValue: (_ lhs: Decimal) -> Decimal = { $0 / 100 }
        
        switch editingSide {
        case .leftHandSide:
            equation.lhs = calculatePercentageValue(equation.lhs)
        case .rightHandSide:
            
            guard let decimal = equation.rhs else {
                return
            }
            
            equation.rhs = calculatePercentageValue(decimal)
        }
    }
    
    mutating func applyDecimalPoint() {
        guard isCompleted == false else { return }
        
        isEnteringDecimal = true
        
        applyDecimalToDisplayString()
    }
    
    private mutating func applyDecimalToDisplayString() {
        
        // first entry
        switch editingSide {
        case .leftHandSide:
            if lcdDisplayString == nil {
               lcdDisplayString = equation.lhs.formatted()
            }
            
        case .rightHandSide:
            if equation.rhs == nil {
                equation.rhs = Decimal(0)
                lcdDisplayString = equation.rhs?.formatted() ?? ""
            }
        }
        
        // update display
        if lcdDisplayString?.contains(decimalSymbol) == false {
            lcdDisplayString?.append(decimalSymbol)
        }
    }
    
    // MARK: - Math Operations
    mutating func divide() {
        guard isCompleted == false else { return }
        
        equation.operation = .divide
        editingSide = .rightHandSide
        isEnteringDecimal = false
    }
    
    mutating func add() {
        guard isCompleted == false else { return }
        
        equation.operation = .add
        editingSide = .rightHandSide
        isEnteringDecimal = false
    }
    
    mutating func subtract() {
        guard isCompleted == false else { return }
        
        equation.operation = .subtract
        editingSide = .rightHandSide
        isEnteringDecimal = false
    }
    
    mutating func multiply() {
        guard isCompleted == false else { return }
        
        equation.operation = .multiply
        editingSide = .rightHandSide
        isEnteringDecimal = false
    }
    
    mutating func execute() {
        guard isCompleted == false else { return }
        
        equation.execute()
    }
    
    mutating func enterNumber(_ number: Int) {
        guard isCompleted == false else { return }
        
        /* READ ME:
         We MUST record the entered string in order to compute the values
         i.e. what if the user wanted to enter 0.001
         
         we cannot represent this data in a numeric value
         i.e. the user needs to first type 0.00
         This will be stored as 0.0 using a Decimal type
         
         Therefore, we must record the string value entered
         */
        
        // entering a value
        let decimalInput = Decimal(number)
        let stringInput = String(number)
        
        // switch sides
        if let _ = equation.operation,
            editingSide == .leftHandSide {
            editingSide = .rightHandSide
        }
        
        // Replace right hand side?
        if
            equation.rhs == nil,
            editingSide == .rightHandSide {
            
            guard isEnteringDecimal else {
                equation.rhs = decimalInput
                lcdDisplayString = stringInput
                return
            }
            
            let initialValue = Decimal(0)
            equation.rhs = initialValue
            lcdDisplayString = initialValue.formatted()
            
            let tuple = appendNewNumber(number, toPreviousEntry: initialValue, previousLCDDisplay: lcdDisplayString ?? "", amendAterDecimalPoint: isEnteringDecimal)
            equation.rhs = tuple.decimal
            lcdDisplayString = tuple.stringRepresentation
            return 
        }
        
        // Always have lhs or rhs value - append new value.
        switch editingSide {
        case .leftHandSide:
            
            let tuple = appendNewNumber(number, toPreviousEntry: equation.lhs, previousLCDDisplay: lcdDisplayString ?? "", amendAterDecimalPoint: isEnteringDecimal)
            equation.lhs = tuple.decimal
            lcdDisplayString = tuple.stringRepresentation
            
        case .rightHandSide:
            guard let currentDecimal = equation.rhs else { return }
            
            let tuple = appendNewNumber(number, toPreviousEntry: currentDecimal, previousLCDDisplay: lcdDisplayString ?? "", amendAterDecimalPoint: isEnteringDecimal)
            equation.rhs = tuple.decimal
            lcdDisplayString = tuple.stringRepresentation
        }
    }
    
    private func appendNewNumber(_ number: Int, toPreviousEntry previousEntry: Decimal, previousLCDDisplay: String?, amendAterDecimalPoint: Bool) -> (decimal: Decimal, stringRepresentation: String) {
        
        let decimalInput = Decimal(number)
        let stringInput = String(number)
        
        // first entry
        if
            previousEntry.isZero,
            previousLCDDisplay == nil {
            return (decimalInput, stringInput)
        }
        
        guard let localPreviousLCDDisplay = previousLCDDisplay else {
            return (Decimal.nan, "NaN")
        }
        
        // entering decimal
        if amendAterDecimalPoint {
            
            // Append a decimal?
            let newStringRepresentation: String = {
                
                var string: String = localPreviousLCDDisplay
                if localPreviousLCDDisplay.contains(decimalSymbol) == false {
                    string = localPreviousLCDDisplay.appending(decimalSymbol)
                }
                string.append(stringInput)
                return string
            }()
            
            // convert to a decimal value
            if let newDecimal = Decimal(string: newStringRepresentation) {
                return (newDecimal, newStringRepresentation)
            }
            
            // we cannot convert the string into a decimal! NAN
            let nan = Decimal.nan
            return (nan, nan.formatted())
            
        }
        
        // non decimal input
        var newStringRepresentation = ""
        if previousEntry.isZero == false {
            newStringRepresentation = localPreviousLCDDisplay
        }
            
            
        newStringRepresentation.append(stringInput)
        if let newDecimal = Decimal(string: newStringRepresentation) {
            return (newDecimal, newStringRepresentation)
        }
        
        // we cannot convert the string into a decimal! NAN
        let nan = Decimal.nan
        return (nan, nan.formatted())
    }
    
}
