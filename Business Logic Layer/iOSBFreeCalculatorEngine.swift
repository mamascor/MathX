//
//  iOSBFreeCalculatorEngine.swift
//  Calc
//
//  Created by Matthew Paul Harding on 25/01/2022.
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

struct iOSBFreeCalculatorEngine {
    
    // MARK: - Enum Display Type
    enum DisplayType {
        case result
        case operand
    }
    
    // MARK: - Variables
    private var historyLog: [MathEquation] = []
    private var currentMathEntry: MathEntry = MathEntry()
    private var displayType: DisplayType = .operand // TODO do we need this property?
    
    // MARK: - Managers
    private let dataStore = DataStore(key: "iOSBFree.com.calc.CalculatorEngine.total")
    
    // MARK: - Display
    var lcdDisplayText: String {
        
        
        if currentMathEntry.isCompleted {
            return currentMathEntry.equation.result?.formatted() ?? ""
        }
        
        if let rhs = currentMathEntry.equation.rhs {
            return rhs.formatted()
        }
        
        return currentMathEntry.equation.lhs.formatted()
        
        /*
        guard currentMathEntry.isCompleted == false else {
            return formatForLCDDisplay(currentMathEntry.equation.result)
        }
        
        switch currentMathEntry.editingSide {
        case .leftHandSide:
            return formatForLCDDisplay(currentMathEntry.equation.lhs)
        case .rightHandSide:
            return formatForLCDDisplay(currentMathEntry.equation.rhs)
        }
         */
    }
    
    var decimalRepresentationOfEditingOperand: Decimal {
        currentMathEntry.decimalRepresentationOfEditingOperand
    }

    var leftHandOperand: Decimal {
        currentMathEntry.equation.lhs
    }
    
    var rightHandOperand: Decimal? {
        currentMathEntry.equation.rhs
    }
    
    var resultOfEquation: Decimal? {
        currentMathEntry.equation.result
    }
    
    // MARK: - Interaction API
    
    var copyOfEquationLog: [MathEquation] {
        return historyLog
    }
    
    mutating func clearHistory() {
            historyLog = []
    }
    
    mutating func clearPressed() {
        currentMathEntry = MathEntry()
        displayType = .operand
    }
    
    mutating func negatePressed() {
        populatePreviousResultIfNeeded(true)
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
        
        guard currentMathEntry.isReadyToExecute else {
            return
        }
        
        executeCurrentMathEntry()
    }
    
    // MARK: - Equation Execution
    
    private mutating func executeCurrentMathEntry() {
        currentMathEntry.execute()
        displayType = .result
        historyLog.append(currentMathEntry.equation)
        printEquation(currentMathEntry.equation)
        saveSession()
    }
    
    // MARK: - Print To Console
    
    private func printEquation(_ equation: MathEquation) {
        
        var operatorString = ""
        switch equation.operation {
        case .multiply: operatorString = "*"
        case .divide: operatorString = "/"
        case .add: operatorString = "+"
        case .subtract: operatorString = "-"
        case .none:
            break
        }
        
        print(equation.lhs.formatted() + " " + operatorString + " " + (equation.rhs?.formatted() ?? "") + " = " + (equation.result?.formatted() ?? ""))
    }
    
    // MARK: - Number Entry
    
    mutating func numberPressed(_ number: Int) {
        
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntry()
        }
        
        currentMathEntry.enterNumber(number)
    }
    
    // MARK: - Business Logic & Behaviour
    
    private mutating func commitCurrentEquationIfNeeded() -> Bool {
        if currentMathEntry.isCompleted == false,
           currentMathEntry.isReadyToExecute {
            executeCurrentMathEntry()
            return true
        }
        
        return false
    }
    
    private mutating func populateCurrentMathEntryWithPreviousResult(_ continueEditingResult: Bool = false) {
        
        var newMathEntry = MathEntry()
        newMathEntry.equation.lhs = currentMathEntry.equation.result ?? 0
        if continueEditingResult == false {
            newMathEntry.editingSide = .rightHandSide
        }
        currentMathEntry = newMathEntry
        displayType = .operand
    }
    
    private mutating func commitAndPopulatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        
        // Scenario 1: user enters 5 * 5 *
        if commitCurrentEquationIfNeeded() {
            populateCurrentMathEntryWithPreviousResult(continueEditingResult)
        }
        
        // secanrio 2: user enters 5 * 5 = *
        if currentMathEntry.isCompleted {
            populateCurrentMathEntryWithPreviousResult()
        }
    }
    
    private mutating func populatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        
        // secanrio 1: user enters 5 * 5 = %
        if currentMathEntry.isCompleted {
            populateCurrentMathEntryWithPreviousResult(continueEditingResult)
        }
    }
    
    // MARK: - Restoring Session
    
    mutating func restoreFromLastSession() {
        let previousSessionResult = dataStore.loadDecimal()
        
        // mimic the behaviour as if the user had just executed an equation with the previuosly seen result displayed
        var newMathEntry = MathEntry()
        newMathEntry.equation.lhs = 1
        newMathEntry.equation.operation = .multiply
        newMathEntry.equation.rhs = previousSessionResult
        newMathEntry.execute()
        currentMathEntry = newMathEntry
        displayType = .result
    }
    
    private func saveSession() {
        if let result = currentMathEntry.equation.result,
            currentMathEntry.isCompleted {
            dataStore.saveDecimal(result)
        }
    }
    
    // MARK: - Copy & Paste
    
    mutating func pasteIn(_ decimal: Decimal) {
        
        // Are we displaying a completed equation?
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntry()
            displayType = .operand
        }
        
        // save the value
        switch currentMathEntry.editingSide {
        case .leftHandSide: currentMathEntry.equation.lhs = decimal
        case .rightHandSide: currentMathEntry.equation.rhs = decimal
        }
    }
    
    mutating func pasteIn(_ mathEquation: MathEquation) {
        
        // Are we displaying a completed equation?
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntry()
            displayType = .operand
        }
        
        currentMathEntry.equation = mathEquation
    }
}
