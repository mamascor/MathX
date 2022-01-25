//
//  iOSBFreeCalculatorEngine.swift
//  Calc
//
//  Created by Matthew Paul Harding on 25/01/2022.
//

import Foundation

struct MathEquation {
    
    enum OperationType {
        case add
        case subtract
        case divide
        case multiply
    }
    
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
    
    enum OperationSide {
        case leftHandSide
        case rightHandSide
    }
    
    var equation: MathEquation = MathEquation()
    var currentlyEditing: OperationSide = .leftHandSide
    var currentlyEnteringDecimal: Bool = false
    var enteredString: String? // Tracking the string input from user
    
    var isCompleted: Bool {
        return equation.executed
    }
    
    mutating func negate() {
        switch currentlyEditing {
        case .leftHandSide:
            equation.lhs.negate()
        case .rightHandSide:
            equation.rhs?.negate()
        }
    }
    
    mutating func applyPercentage() {
        
        let calculatePercentageValue: (_ lhs: Decimal) -> Decimal = { $0 / 100 }
        
        switch currentlyEditing {
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
        currentlyEnteringDecimal = true
    }
    
    mutating func divide() {
        equation.operation = .divide
    }
    
    mutating func add() {
        equation.operation = .add
    }
    
    mutating func subtract() {
        equation.operation = .subtract
    }
    
    mutating func multiply() {
        equation.operation = .multiply
    }
    
    mutating func execute() {
        equation.execute()
    }
}

struct iOSBFreeCalculatorEngine {
    
    // MARK: - Constants
    let decimalSymbol = Locale.current.decimalSeparator ?? "."
    
    // MARK: - Managers
    private let calculator = Calculator()
    
    // MARK: - Variables
    private var historyLog: [MathEquation] = []
    private var currentMathEntry: MathEntry = MathEntry()
    
    // MARK: - Display
    private let lcdDisplayFormatter = DisplayFormatter(maximumCharactersForDisplay: 9)
    
    var lcdDisplayText: String {
        
        guard currentMathEntry.isCompleted == false else {
            return formatForLCDDisplay(currentMathEntry.equation.result)
        }
        
        switch currentMathEntry.currentlyEditing {
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
    }
    
    mutating func negatePressed() {
        currentMathEntry.negate()
    }
    
    mutating func percentagePressed() {
        currentMathEntry.applyPercentage()
    }
    
    mutating func decimalPressed() {
        currentMathEntry.applyDecimalPoint()
    }
    
    // MARK: - Operations
    
    mutating func addPressed() {
        currentMathEntry.add()
    }
    
    mutating func minusPressed() {
        currentMathEntry.subtract()
    }
    
    mutating func multiplyPressed() {
        currentMathEntry.multiply()
    }
    
    mutating func dividePressed() {
        currentMathEntry.divide()
    }
    
    mutating func equalsPressed() {
        currentMathEntry.execute()
        historyLog.append(currentMathEntry.equation)
    }
    
    // MARK: - Number Entry
    
    mutating func numberPressed(_ number: Int) {
        
    }
    
    
}

// MARK: - Presentation Logic

extension iOSBFreeCalculatorEngine {
    
    func formatForLCDDisplay(_ decimal: Decimal?) -> String {
        guard let decimalNumber = decimal else { return "" }
        
        return lcdDisplayFormatter.formatForDisplay(decimalNumber)
    }
}
