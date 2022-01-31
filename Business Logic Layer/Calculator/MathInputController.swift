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
    
    enum OperationSide {
        case leftHandSide
        case rightHandSide
    }
    
    // MARK: - Constants
    
    private let decimalSymbol = Locale.current.decimalSeparator ?? "."
    private let errorMessage = "Error"
    
    // MARK: - variables
    
    var equation: MathEquation = MathEquation()
    var editingSide: OperationSide = .leftHandSide
    var isEnteringDecimal: Bool = false
    
    // MARK: - Display
    
    private(set) var lcdDisplayText = ""
    
    private var decimalToDisplayToTheUser: Decimal {
        if let result = result {
            return result
        }
        
        switch editingSide {
        case .leftHandSide:
            return equation.lhs
        case .rightHandSide:
            return equation.rhs ?? equation.lhs
        }
    }
    
    private func formatForLCDDisplay(_ decimal: Decimal?) -> String {
        return decimal?.formatted() ?? errorMessage
//        return scientificCalcFormatter.string(from: decimalToDisplayToTheUser as NSDecimalNumber) ?? errorMessage
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
        
        if let _ = equation.operation,
           let _ = equation.rhs {
            return true
        }
        
        return false
    }
    
    var containsNans: Bool {
        equation.lhs.isNaN || (equation.rhs?.isNaN ?? false) || (equation.result?.isNaN ?? false)
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
        if editingSide == .rightHandSide,
           equation.rhs == nil {
            equation.rhs = Decimal(0)
            lcdDisplayText = formatForLCDDisplay(equation.rhs)
        }
        
        if lcdDisplayText.contains(decimalSymbol) == false {
            lcdDisplayText.append(decimalSymbol)
        }
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
        
        /* Hello 🤵🏽🧑🏼‍🔧👷‍♂️:
         We must record the entered string in order to compute the values
         i.e. what if the user wanted to enter 0.001
         
         we cannot represent this data in a numeric value
         i.e. the user needs to first type 0.00
         which will be stored as 0.0 using a Decimal type.
         
         Therefore, we must also record the string value entered.
         */
        
        // → Values entered by the user
        let decimalInput = Decimal(number)
        let stringInput = String(number)
        
        // → Switch sides if needed
        if let _ = equation.operation,
            editingSide == .leftHandSide {
            startEditingRightHandSide()
        }
        
        // → No right hand value yet
        if
            equation.rhs == nil,
            editingSide == .rightHandSide {
            
            guard isEnteringDecimal else {
                equation.rhs = decimalInput
                lcdDisplayText = stringInput
                return
            }
            
            let initialValue = Decimal(0)
            equation.rhs = initialValue
            lcdDisplayText = formatForLCDDisplay(initialValue)
            
            let tuple = appendNewNumber(number, toPreviousEntry: initialValue, previousLCDDisplay: lcdDisplayText, amendAterDecimalPoint: isEnteringDecimal)
            equation.rhs = tuple.decimal
            lcdDisplayText = tuple.stringRepresentation
            return 
        }
        
        // → We have an existing value - append new value.
        switch editingSide {
        case .leftHandSide:
            
            let tuple = appendNewNumber(number, toPreviousEntry: equation.lhs, previousLCDDisplay: lcdDisplayText, amendAterDecimalPoint: isEnteringDecimal)
            equation.lhs = tuple.decimal
            lcdDisplayText = tuple.stringRepresentation
            
        case .rightHandSide:
            guard let currentDecimal = equation.rhs else { return }
            
            let tuple = appendNewNumber(number, toPreviousEntry: currentDecimal, previousLCDDisplay: lcdDisplayText, amendAterDecimalPoint: isEnteringDecimal)
            equation.rhs = tuple.decimal
            lcdDisplayText = tuple.stringRepresentation
        }
    }
    
    private func appendNewNumber(_ number: Int, toPreviousEntry previousEntry: Decimal, previousLCDDisplay: String?, amendAterDecimalPoint: Bool) -> (decimal: Decimal, stringRepresentation: String) {
        let stringInput = String(number)
        guard let localPreviousLCDDisplay = previousLCDDisplay else {
            return (Decimal.nan, "NaN")
        }
        
        // → User is entering a decimal value
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
            return (nan, errorMessage)
            
        }
        
        // → Not a decimal - An integer value
        var newStringRepresentation = ""
        if previousEntry.isZero == false {
            newStringRepresentation = localPreviousLCDDisplay
        }  
        newStringRepresentation.append(stringInput)
        if let newDecimal = Decimal(string: newStringRepresentation) {
            return (newDecimal, newStringRepresentation)
        }
        
        // → Error scenario: We cannot convert the string into a decimal
        let nan = Decimal.nan
        return (nan, errorMessage)
    }
    
    // MARK: - Copy & Paste
    
    mutating func pasteIn(_ decimal: Decimal) {
        switch editingSide {
            case .leftHandSide: equation.lhs = decimal
            case .rightHandSide: equation.rhs = decimal
        }
        lcdDisplayText = formatForLCDDisplay(decimal)
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
        return equation.lhs
    }
    
    var rhs: Decimal? {
        return equation.rhs
    }
    
    var result: Decimal? {
        return equation.result
    }
    
    var operation: MathEquation.OperationType? {
        return equation.operation
    }
    
    mutating func setLHS(_ decimal: Decimal?) {
        guard let decimal = decimal else {
            return
        }
        equation.lhs = decimal
        lcdDisplayText = formatForLCDDisplay(decimal)
    }
    
    mutating func setRHS(_ decimal: Decimal?) {
        guard let decimal = decimal else {
            return
        }
        equation.rhs = decimal
        startEditingRightHandSide()
        lcdDisplayText = formatForLCDDisplay(decimal)
    }
    
    mutating func startEditingRightHandSide() {
        editingSide = .rightHandSide
    }
    
    mutating func setResult(_ decimal: Decimal?) {
        guard let decimal = decimal else {
            return
        }
        equation.result = decimal
        lcdDisplayText = formatForLCDDisplay(decimal)
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
