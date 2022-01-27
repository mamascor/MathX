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
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//  Tell us what you want to learn  → community@iosbfree.com
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
    }
    
    // MARK: - Math Operations
    mutating func divide() {
        guard isCompleted == false else { return }
        
        equation.operation = .divide
        editingSide = .rightHandSide
    }
    
    mutating func add() {
        guard isCompleted == false else { return }
        
        equation.operation = .add
        editingSide = .rightHandSide
    }
    
    mutating func subtract() {
        guard isCompleted == false else { return }
        
        equation.operation = .subtract
        editingSide = .rightHandSide
    }
    
    mutating func multiply() {
        guard isCompleted == false else { return }
        
        equation.operation = .multiply
        editingSide = .rightHandSide
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
            equation.rhs = decimalInput
            lcdDisplayString = stringInput
            return
        }
        
        // Always have lhs or rhs value - append new value.
        switch editingSide {
        case .leftHandSide:
            
            let tuple = appendNewNumber(number, toPreviousEntry: equation.lhs, withStringRepresentation: lcdDisplayString ?? "", amendAterDecimalPaoint: isEnteringDecimal)
            equation.lhs = tuple.decimal
            lcdDisplayString = tuple.stringRepresentation
            
        case .rightHandSide:
            guard let currentDecimal = equation.rhs else { return }
            
            let tuple = appendNewNumber(number, toPreviousEntry: currentDecimal, withStringRepresentation: lcdDisplayString ?? "", amendAterDecimalPaoint: isEnteringDecimal)
            equation.rhs = tuple.decimal
            lcdDisplayString = tuple.stringRepresentation
        }
    }
    
    private func appendNewNumber(_ number: Int, toPreviousEntry previousEntry: Decimal, withStringRepresentation stringRepresentation: String, amendAterDecimalPaoint: Bool) -> (decimal: Decimal, stringRepresentation: String) {
        
        let decimalInput = Decimal(number)
        let stringInput = String(number)
        
        if previousEntry.isZero {
            
            // replace if we only have a zero value (0 not 0.)
            if amendAterDecimalPaoint {
                
                // Append a decimal?
                let newStringRepresentation: String = {
                    
                    var string: String = ""
                    if stringRepresentation.contains(decimalSymbol) == false {
                        string = stringRepresentation.appending(decimalSymbol)
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
                
            } else {
                
                // we have 0. Replace with the new number
                return (decimalInput, stringInput)
            }
        } else {
            
            if amendAterDecimalPaoint {
                
                // Append a decimal?
                let newStringRepresentation: String = {
                    
                    var string: String = stringRepresentation
                    if stringRepresentation.contains(decimalSymbol) == false {
                        string = stringRepresentation.appending(decimalSymbol)
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
                
            } else {
                let newStringRepresentation = stringRepresentation.appending(stringInput)
                
                // convert to a decimal value
                if let newDecimal = Decimal(string: newStringRepresentation) {
                    return (newDecimal, newStringRepresentation)
                }
                
                // we cannot convert the string into a decimal! NAN
                let nan = Decimal.nan
                return (nan, nan.formatted())
            }
        }
    }
    
}
