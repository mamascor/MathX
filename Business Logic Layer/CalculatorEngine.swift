//
//  CalculatorEngine.swift
//  Calc
//
//  Created by Matthew Paul Harding on 01/01/22.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
//

import Foundation

struct CalculatorEngine {
    
    // MARK: - Enums
    enum OperationType {
        case none, addiction, substraction, multiplication, division
    }
    
    // MARK: - Constants
    let decimalSymbol = Locale.current.decimalSeparator!
    
    // MARK: - Managers
    private let dataStore = DataStore(key: "iOSBFree.com.calc.CalculatorEngine.total")
    private let displayFormatter = DisplayFormatter(maximumCharactersForDisplay: 9)
    private let calculator = Calculator()
    
    // MARK: - Variables
    private var equationResult: Double = 0
    private var queuedNumber: Double = 0
    var operating = false
    private var decimal = false
    var operation: CalculatorEngine.OperationType = .none
    
    // MARK: - State Variables
    private var equationHistory: [String] = []
    private var leftHandValue: String?
    private var rightHandValue: String?
    private var calculatedValue: String?
    
    
    // MARK: - Restoring Session
    
    mutating func restoreFromLastSession() -> Double {
        
        guard operation == .none else {
            return 0
        }
        
        equationResult = dataStore.loadResult() ?? 0
        return equationResult
    }
    
    private func saveSession() {
        dataStore.saveResult(equationResult)
    }
    
    
    // MARK: - Math
    
    private mutating func executeQueuedEquation() -> Double? {
        
        let leftHandValue = equationResult
        var printedEquation: String
        
        switch operation {
        case .none:
            return nil
            
        case .addiction:
            equationResult = calculator.execute(leftHandValue, add: queuedNumber)
            printedEquation = formatForDisplay(number: leftHandValue) + " + " + formatForDisplay(number: queuedNumber) + " = " + formatForDisplay(number: equationResult)
            
        case .substraction:
            equationResult = calculator.execute(leftHandValue, minus: queuedNumber)
            printedEquation = formatForDisplay(number: leftHandValue) + " - " + formatForDisplay(number: queuedNumber) + " = " + formatForDisplay(number: equationResult)
            
        case .multiplication:
            equationResult = calculator.execute(leftHandValue, multiply: queuedNumber)
            printedEquation = formatForDisplay(number: leftHandValue) + " * " + formatForDisplay(number: queuedNumber) + " = " + formatForDisplay(number: equationResult)
            
        case .division:
            equationResult = calculator.execute(leftHandValue, divide: queuedNumber)
            printedEquation = formatForDisplay(number: leftHandValue) + " ÷ " + formatForDisplay(number: queuedNumber) + " = " + formatForDisplay(number: equationResult)
        }
        
        equationHistory.append(printedEquation)
        print(printedEquation)
        
        operation = .none
        saveSession()
    
        return equationResult
    }

    // MARK: - Interaction API
    
    mutating func clearPressed() -> Double {
        operation = .none
        queuedNumber = 0
        equationResult = 0
        return equationResult
    }
    
    mutating func negatePressed() -> Double  {
        queuedNumber =  calculator.negate(queuedNumber)
        return queuedNumber
    }
    
    mutating func percentagePressed() -> Double  {
        
        queuedNumber = calculator.decimalPercentage(queuedNumber)
        return queuedNumber
    }
    
    mutating func decimalPressed() -> Double {
        
        decimal = true
        return queuedNumber
    }
    
    // MARK: - Operations
    
    mutating func addPressed() -> Double?  {
        
        guard operation != .addiction else {
            return nil
        }
        
        let displayValue: Double = executeQueuedEquation() ?? queuedNumber
        
        operating = true
        operation = .addiction
        return displayValue
    }
    
    mutating func minusPressed() -> Double? {
        guard operation != .substraction else {
            return nil
        }
        
        let displayValue: Double = executeQueuedEquation() ?? queuedNumber
        operating = true
        operation = .substraction
        return displayValue
    }
    
    mutating func multiplyPressed() -> Double?  {
        guard operation != .multiplication else {
            return nil
        }
        
        let displayValue: Double = executeQueuedEquation() ?? queuedNumber
        operating = true
        operation = .multiplication
        return displayValue
    }
    
    mutating func dividePressed() -> Double?  {
        guard operation != .division else {
            return nil
        }
        let displayValue: Double = executeQueuedEquation() ?? queuedNumber
        operating = true
        operation = .division
        return displayValue
    }
    
    mutating func equalsPressed() -> Double? {
        
        let displayNumber = executeQueuedEquation()
        operation = .none
        queuedNumber = equationResult
        
        return displayNumber
    }
    
    // MARK: - Number Entry
    
    mutating func numberPressed(_ number: Int) -> Double {
        
        var currentTemp = displayFormatter.auxTotalFormatter.string(from: NSNumber(value: queuedNumber))!
        if !operating && currentTemp.count >= displayFormatter.maximumCharactersForDisplay { // todo. this code is strange
            return queuedNumber
        }
        
        currentTemp = displayFormatter.auxFormatter.string(from: NSNumber(value: queuedNumber))!
        
        if operating {
            equationResult = equationResult == 0 ? queuedNumber : equationResult
            
            currentTemp = ""
            operating = false
        }
        
        if decimal {
            currentTemp = "\(currentTemp)\(decimalSymbol)"
            decimal = false
        }

        queuedNumber = Double(currentTemp + String(number))!    // crashes due to force unwrappin the optional
        return queuedNumber
    }
    
    
}

// MARK: - Presentation Logic

extension CalculatorEngine {
    
    func formatForDisplay(number: Double) -> String {
        return displayFormatter.formatForDisplay(number: number)
    }
}
