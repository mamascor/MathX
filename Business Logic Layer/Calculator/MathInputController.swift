//
//  MathInputController.swift
//  Calc
//
//  Created by iOSB Free on 26/01/2022.
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
//   It's a manager for one equation. In charge of input and what is displayed to the user.
//   Architecural Layer: Business Logic Layer
//
//   💡 Architecture Tip 👉🏻 Try to restrict each file to one single purpose, which is known
//   as having a single responsibility. Why not google "single responsibility software"
// *******************************************************************************************


import Foundation

struct MathInputController {
    
    // MARK: - Operation Side Enum
    
    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }
    
    // MARK: - Constants
    
    private let decimalSymbol = Locale.current.decimalSeparator ?? "."
    private let groupingSymbol = Locale.current.groupingSeparator ?? ","
    private let minusSymbol = "-"
    private let errorMessage = "Error"
    
    // MARK: - variables
    
    private(set) var equation = MathEquation()
    private var editingSide: OperandSide = .leftHandSide
    private var isEnteringDecimal = false
    
    // MARK: - Display
    
    private(set) var lcdDisplayText = ""
    
    private func formatForLCDDisplay(_ decimal: Decimal?) -> String {
        guard decimal?.isNaN == false else { return errorMessage }
        return decimal?.formatted() ?? errorMessage
    }
    
    // MARK: - Initialiser
    
    init() {
        lcdDisplayText = formatForLCDDisplay(equation.lhs)
    }
    
    // MARK: - Completed Equation
    
    var isCompleted: Bool {
        return equation.executed
    }
    
    var isReadyToExecute: Bool {
        guard equation.executed == false else {
            return false
        }
        
        if let _ = operation,
           let _ = rhs {
            return true
        }
        
        return false
    }
    
    var containsNans: Bool {
        lhs.isNaN || (rhs?.isNaN ?? false) || (result?.isNaN ?? false)
    }
    
    // MARK: - Extra Functions
    
    mutating func negate() {
        guard isCompleted == false else { return }
        
        switch editingSide {
        case .leftHandSide:
            equation.negateLeftHandSide()
            displayNegateSymbolOnDisplay(lhs)
        case .rightHandSide:
            equation.negateRightHandSide()
            displayNegateSymbolOnDisplay(rhs)
        }
    }
    
    private mutating func displayNegateSymbolOnDisplay(_ decimal: Decimal?) {
        guard let decimal = decimal else { return }
        
        var isNegativeValue = false
        if decimal < 0 {
            isNegativeValue = true
        }
        
        if isNegativeValue {
            lcdDisplayText.addPrefixIfNeeded(minusSymbol)
        } else {
            lcdDisplayText.removePrefixIfNeeded(minusSymbol)
        }
    }
    
    mutating func applyPercentage() {
        guard isCompleted == false else { return }
        
        switch editingSide {
        case .leftHandSide:
            equation.applyPercentageToLeftHandSide()
            lcdDisplayText = formatForLCDDisplay(lhs)
        case .rightHandSide:
            guard let _ = rhs else { return }
            equation.applyPercentageToRightHandSide()
            lcdDisplayText = formatForLCDDisplay(rhs)
        }
    }

    mutating func applyDecimalPoint() {
        guard isCompleted == false else { return }
        isEnteringDecimal = true
        
        if editingSide == .rightHandSide,
           rhs == nil {
            rhs = Decimal(0)
        }
        
        lcdDisplayText = applyDecimalToString(lcdDisplayText)
    }
    
    private func applyDecimalToString(_ string: String) -> String {
        if string.contains(decimalSymbol) {
            return string
        }
        return string.appending(decimalSymbol)
    }
    
    // MARK: - Math Operations
    
    mutating func divide() {
        guard isCompleted == false else { return }
        setOperation(.divide)
    }
    
    mutating func add() {
        guard isCompleted == false else { return }
        setOperation(.add)
    }
    
    mutating func subtract() {
        guard isCompleted == false else { return }
        setOperation(.subtract)
    }
    
    mutating func multiply() {
        guard isCompleted == false else { return }
        setOperation(.multiply)
    }
    
    mutating func execute() {
        guard isCompleted == false else { return }
        equation.execute()
        lcdDisplayText = formatForLCDDisplay(equation.result)
    }
    
    mutating func enterNumber(_ number: Int) {
        guard isCompleted == false else { return }
        let decimalInput = Decimal(number)
        
        // → Switch sides if needed
        if let _ = equation.operation,
            editingSide == .leftHandSide {
            startEditingRightHandSide()
        }
        
        // → No right hand value yet
        if
            rhs == nil,
            editingSide == .rightHandSide {
            
            guard isEnteringDecimal else {
                rhs = decimalInput
                return
            }
            
            let initialValue = Decimal(0)
            rhs = initialValue
            
            let tuple = appendNewNumber(number, toPreviousEntry: initialValue, previousLCDDisplay: lcdDisplayText, amendAterDecimalPoint: isEnteringDecimal)
            rhs = tuple.decimal
            lcdDisplayText = tuple.stringRepresentation
            return 
        }
        
        // → We have an existing value - append new value.
        switch editingSide {
        case .leftHandSide:
            let tuple = appendNewNumber(number, toPreviousEntry: equation.lhs, previousLCDDisplay: lcdDisplayText, amendAterDecimalPoint: isEnteringDecimal)
            lhs = tuple.decimal
            lcdDisplayText = tuple.stringRepresentation
            
        case .rightHandSide:
            guard let currentDecimal = equation.rhs else { return }
            
            let tuple = appendNewNumber(number, toPreviousEntry: currentDecimal, previousLCDDisplay: lcdDisplayText, amendAterDecimalPoint: isEnteringDecimal)
            rhs = tuple.decimal
            lcdDisplayText = tuple.stringRepresentation
        }
    }
    
    private func appendNewNumber(_ number: Int, toPreviousEntry previousEntry: Decimal, previousLCDDisplay: String?, amendAterDecimalPoint: Bool) -> (decimal: Decimal, stringRepresentation: String) {
        /* Hello 🤵🏽🧑🏼‍🔧👷‍♂️:
         We must record the entered string in order to compute the values
         i.e. what if the user wanted to enter 0.001
         The user would need to first enter 0.00,
         which would numerically be 0.0
         and not presevre the desired input of 0.00
         
         Therefore.. we must also record the input as a string.
         */
        let stringInput = String(number)
        guard let localPreviousLCDDisplay = previousLCDDisplay else {
            return (Decimal.nan, errorMessage)
        }
        
        // → User is entering a decimal value
        if amendAterDecimalPoint {
            
            // Append a decimal?
            let newStringRepresentation: String = {
                return applyDecimalToString(localPreviousLCDDisplay).appending(stringInput)
            }()
            
            // convert to a decimal value
            if let newDecimal = Decimal(string: newStringRepresentation) {
                return (newDecimal, newStringRepresentation)
            }
            
            // we cannot convert the string into a decimal! NAN
            let nan = Decimal.nan
            return (nan, errorMessage)
        }
        
        // → Not a decimal - An integer value
        var newStringRepresentation = ""
        if previousEntry.isZero == false {
            newStringRepresentation = localPreviousLCDDisplay
        }  
        newStringRepresentation.append(stringInput)
        
        // → Remove formatting
        let elements = newStringRepresentation.components(separatedBy: groupingSymbol)
        var representationWithoutFormatting = ""
        for (_, stringElement) in elements.enumerated() {
            representationWithoutFormatting = representationWithoutFormatting + stringElement
        }
        
        // → Convert to a numeric value
        if
            let newDecimal = Decimal(string: representationWithoutFormatting) {
            if amendAterDecimalPoint == false {
                newStringRepresentation = formatForLCDDisplay(newDecimal)
            }
            return (newDecimal, newStringRepresentation)
        }
        
        // → Error scenario: We cannot convert the string into a decimal
        let nan = Decimal.nan
        return (nan, errorMessage)
    }
    
    // MARK: - Copy & Paste
    
    mutating func pasteIn(_ decimal: Decimal) {
        switch editingSide {
            case .leftHandSide: lhs = decimal
            case .rightHandSide: rhs = decimal
        }
    }
    
    // MARK: - Print Description
    
    var equationDescription: String {
        var operatorString = ""
        switch equation.operation {
        case .multiply: operatorString = "*"
        case .divide: operatorString = "/"
        case .add: operatorString = "+"
        case .subtract: operatorString = "-"
        case .none:
            break
        }
        
        return formatForLCDDisplay(equation.lhs) + " " + operatorString + " " + formatForLCDDisplay(equation.rhs) + " = " + formatForLCDDisplay(equation.result)
    }
    
    // MARK: - Set LHS & RHS Values
    
    var lhs: Decimal {
        get {
            return equation.lhs
        }
        set {
            equation.lhs = newValue
            lcdDisplayText = formatForLCDDisplay(newValue)
        }
    }
    
    var rhs: Decimal? {
        get {
            return equation.rhs
        }
        set {
            guard let decimal = newValue else {
                return
            }
            equation.rhs = decimal
            startEditingRightHandSide()
            lcdDisplayText = formatForLCDDisplay(decimal)
        }
    }
    
    var result: Decimal? {
        return equation.result
    }
    
    var operation: MathEquation.OperationType? {
        return equation.operation
    }
    
    mutating func startEditingRightHandSide() {
        editingSide = .rightHandSide
    }
    
    mutating func setOperation(_ operation: MathEquation.OperationType?) {
        guard let operation = operation else {
            return
        }
        equation.operation = operation
        startEditingRightHandSide()
        isEnteringDecimal = false
    }
}
