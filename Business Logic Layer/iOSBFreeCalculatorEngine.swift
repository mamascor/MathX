//
//  iOSBFreeCalculatorEngine.swift
//  Calc
//
//  Created by Matthew Paul Harding on 25/01/2022.
//

import Foundation

struct MathEquation {
    
    // MARK: - Operation Enum
    enum OperationType {
        case add
        case subtract
        case divide
        case multiply
    }
    
    // MARK: - Variables
    var lhs: Decimal = 0
    var rhs: Decimal?
    var operation: OperationType?
    var result: Decimal?
    
    var executed: Bool {
        return result != nil
    }
    
    mutating func execute() {
        guard let rightHandSide = rhs else { return }
        
        switch operation {
        case .multiply:
        result = lhs * rightHandSide
        case .subtract:
            result = lhs - rightHandSide
        case .add:
            result = lhs + rightHandSide
        case .divide:
            result = lhs / rightHandSide
        case .none:
            break
        }
    }
}

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
        if let _ = equation.operation,
           let _ = equation.rhs {
            return true
        }
        
        return false
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
    }
    
    mutating func add() {
        guard isCompleted == false else { return }
        
        equation.operation = .add
    }
    
    mutating func subtract() {
        guard isCompleted == false else { return }
        
        equation.operation = .subtract
    }
    
    mutating func multiply() {
        guard isCompleted == false else { return }
        
        equation.operation = .multiply
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

struct iOSBFreeCalculatorEngine {
    
    // MARK: - Enum Display Type
    enum DisplayType {
        case result
        case operand
    }
    
    // MARK: - Variables
    private var historyLog: [MathEquation] = []
    private var currentMathEntry: MathEntry = MathEntry()
    private var displayType: DisplayType = .operand
    
    // MARK: - Display
    private let lcdDisplayFormatter = DisplayFormatter(maximumCharactersForDisplay: 9)
    
    var lcdDisplayText: String {
        
        guard currentMathEntry.isCompleted == false else {
            return formatForLCDDisplay(currentMathEntry.equation.result)
        }
        
        switch currentMathEntry.editingSide {
        case .leftHandSide:
            return formatForLCDDisplay(currentMathEntry.equation.lhs)
        case .rightHandSide:
            return formatForLCDDisplay(currentMathEntry.equation.rhs)
        }
    }

    // MARK: - Interaction API
    
    mutating func clearHistory() {
            historyLog = []
    }
    
    mutating func clearPressed() {
        currentMathEntry = MathEntry()
        displayType = .operand
    }
    
    mutating func negatePressed() {
        populatePreviousResultIfNeeded()
        currentMathEntry.negate()
    }
    
    mutating func percentagePressed() {
        populatePreviousResultIfNeeded()
        currentMathEntry.applyPercentage()
    }
    
    mutating func decimalPressed() {
        
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntry()
        }
        
        currentMathEntry.applyDecimalPoint()
    }
    
    // MARK: - Operations
    
    mutating func addPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        currentMathEntry.add()
    }
    
    mutating func minusPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        currentMathEntry.subtract()
    }
    
    mutating func multiplyPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        currentMathEntry.multiply()
    }
    
    mutating func dividePressed() {
        commitAndPopulatePreviousResultIfNeeded()
        currentMathEntry.divide()
    }
    
    mutating func equalsPressed() {
        
        // Apply the same addition/ multiplation/ subtraction etc to the displayed result
        if currentMathEntry.isCompleted {
            var newMathEntry = MathEntry()
            newMathEntry.equation.lhs = currentMathEntry.equation.result ?? 0
            newMathEntry.equation.operation = currentMathEntry.equation.operation
            newMathEntry.equation.rhs = currentMathEntry.equation.rhs
            currentMathEntry = newMathEntry
        }
        
        executeCurrentMathEntry()
    }
    
    mutating func executeCurrentMathEntry() {
        currentMathEntry.execute()
        displayType = .result
        historyLog.append(currentMathEntry.equation)
    }
    
    // MARK: - Number Entry
    
    mutating func numberPressed(_ number: Int) {
        
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntry()
        }
        
        currentMathEntry.enterNumber(number)
    }
    
    // MARK: - Behaviour
    
    private mutating func commitCurrentEquationIfNeeded() -> Bool {
        if currentMathEntry.isReadyToExecute {
            equalsPressed()
            return true
        }
        
        return false
    }
    
    private mutating func populateCurrentMathEntryWithPreviousResult() {
        if let previousResult = historyLog.last {
            currentMathEntry.equation.lhs = previousResult.result ?? 0
            currentMathEntry.editingSide = .rightHandSide
            displayType = .operand
        }
    }
    
    private mutating func commitAndPopulatePreviousResultIfNeeded() {
        
        // Scenario 1: user enters 5 * 5 *
        if commitCurrentEquationIfNeeded() {
            populateCurrentMathEntryWithPreviousResult()
        }
        
        // secanrio 2: user enters 5 * 5 = *
        if currentMathEntry.isCompleted {
            populateCurrentMathEntryWithPreviousResult()
        }
    }
    
    private mutating func populatePreviousResultIfNeeded() {
        
        // secanrio 1: user enters 5 * 5 = %
        if currentMathEntry.isCompleted {
            populateCurrentMathEntryWithPreviousResult()
        }
    }
    
}

// MARK: - Presentation Logic

extension iOSBFreeCalculatorEngine {
    
    func formatForLCDDisplay(_ decimal: Decimal?) -> String {
        guard let decimalNumber = decimal else { return "" }
        
        return lcdDisplayFormatter.formatForDisplay(decimalNumber)
    }
}
