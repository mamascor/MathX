//
//  iOSBFreeCalculatorEngine.swift
//  Calc
//
//  Created by iOSB Free on 25/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💜 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's the core of the calculator. The brain. It generates all of our behaviour.
//   Architecural Layer: Business Logic Layer
//
//   💡 Testing Tip 👉🏻 By testing the API of iOSBFreeCalculatorEngine we save countless
//   hours worried about a live issue, which could have been prevented by writing unit tests.
// *******************************************************************************************


import Foundation

struct iOSBFreeCalculatorEngine {
    
    // MARK: - Variables
    
    private let errorMessage = "Error"
    private var historyLog: [MathEquation] = []
    private var currentMathEntry: MathEntryController = MathEntryController()
    
    // MARK: - Managers
    
    private let dataStore = DataStoreManager(key: "iOSBFree.com.calc.CalculatorEngine.total")
    
    // MARK: - Scientific Calc Formatter
    
    private let scientificCalcFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
    // MARK: - Display
    
    var lcdDisplayText: String {
        
        // → For A Completed equation
        if currentMathEntry.isCompleted {
            guard currentMathEntry.equation.result?.isNaN == false else {
                return errorMessage
            }
            
            guard let result = currentMathEntry.equation.result else {
                return errorMessage
            }
            
            let formattedResult = result.formatted()
            if formattedResult.count > 12 {
                return scientificCalcFormatter.string(from: result as NSDecimalNumber) ?? errorMessage
            }
            return formattedResult
        }
        
        let formattedResult = currentMathEntry.lcdDisplayString ?? errorMessage
        
        //  → For A Left Or Right Values i.e the operands
        if formattedResult.count > 9 {
            var operand = Decimal.nan
            switch currentMathEntry.editingSide {
            case .leftHandSide:
                operand = currentMathEntry.equation.lhs
                
            case .rightHandSide:
                // If we dont have a rhs value then the user hasnt pressed any keys yet
                operand = currentMathEntry.equation.rhs ?? currentMathEntry.equation.lhs
            }
            return scientificCalcFormatter.string(from: operand as NSDecimalNumber) ?? errorMessage
        }
        
        //  → Display value from MathEntry
        return formattedResult
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
        currentMathEntry = MathEntryController()
    }
    
    mutating func negatePressed() {
        populatePreviousResultIfNeeded(true)
        currentMathEntry.negate()
    }
    
    mutating func percentagePressed() {
        populatePreviousResultIfNeeded(true)
        currentMathEntry.applyPercentage()
    }
    
    mutating func decimalPressed() {
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntryController()
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
        if currentMathEntry.isCompleted {
            var newMathEntry = MathEntryController()
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
        historyLog.append(currentMathEntry.equation)
        printEquationToDebugConsole(currentMathEntry.equation)
        saveSession()
    }
    
    // MARK: - Print To Console
    
    private func printEquationToDebugConsole(_ equation: MathEquation) {
        var operatorString = ""
        switch equation.operation {
        case .multiply: operatorString = "*"
        case .divide: operatorString = "/"
        case .add: operatorString = "+"
        case .subtract: operatorString = "-"
        case .none:
            break
        }
        
        // → Using the print command only works in debug mode
        print(equation.lhs.formatted() + " " + operatorString + " " + (equation.rhs?.formatted() ?? "") + " = " + (equation.result?.formatted() ?? ""))
    }
    
    // MARK: - Number Entry
    
    mutating func numberPressed(_ number: Int) {
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntryController()
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
        var newMathEntry = MathEntryController()
        newMathEntry.equation.lhs = currentMathEntry.equation.result ?? 0
        if continueEditingResult == false {
            newMathEntry.editingSide = .rightHandSide
        }
        currentMathEntry = newMathEntry
    }
    
    private mutating func commitAndPopulatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        
        // → Scenario 1: user enters 5 * 5 *
        if commitCurrentEquationIfNeeded() {
            populateCurrentMathEntryWithPreviousResult(continueEditingResult)
        }
        
        // → secanrio 2: user enters 5 * 5 = *
        if currentMathEntry.isCompleted {
            populateCurrentMathEntryWithPreviousResult()
        }
    }
    
    private mutating func populatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        if currentMathEntry.isCompleted {
            populateCurrentMathEntryWithPreviousResult(continueEditingResult)
        }
    }
    
    // MARK: - Restoring Session
    
    mutating func restoreFromLastSession() -> Bool {
        guard
            let lastExecutedEquation = readSavedEquationFromDisk(),
            let lastExecutedResult = lastExecutedEquation.result
            else {
            return false
        }
        
        var newMathEntry = MathEntryController()
        newMathEntry.equation.lhs = 1
        newMathEntry.equation.operation = .multiply
        newMathEntry.equation.rhs = lastExecutedResult
        newMathEntry.execute()
        currentMathEntry = newMathEntry
        return true
    }
    
    private func saveSession() {
        guard isMathEntrySafeToBeSaved(currentMathEntry) == true else {
            return
        }
         
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currentMathEntry.equation) {
            dataStore.set(encoded)
        }
    }
    
    private func isMathEntrySafeToBeSaved(_ mathEntry: MathEntryController) -> Bool {
        guard mathEntry.containsNans == false,  // crashes when encoding nans
              let _ = mathEntry.equation.result,
              mathEntry.isCompleted
        else {
            return false
        }
        return true
    }
    
    private func readSavedEquationFromDisk() -> MathEquation? {
        guard let savedEquation = dataStore.getValue() as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(MathEquation.self, from: savedEquation)
    }
    
    // MARK: - Copy & Paste
    
    mutating func pasteIn(_ decimal: Decimal) {
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntryController()
        }
        
        switch currentMathEntry.editingSide {
            case .leftHandSide: currentMathEntry.equation.lhs = decimal
            case .rightHandSide: currentMathEntry.equation.rhs = decimal
        }
    }
    
    mutating func pasteIn(_ mathEquation: MathEquation) {
        if currentMathEntry.isCompleted {
            currentMathEntry = MathEntryController()
        }
        currentMathEntry.equation = mathEquation
    }
}
