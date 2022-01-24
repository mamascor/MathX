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
    private let dataStore = DataStore(key: "iOSBFree.com.calc.total")
    private let displayFormatter = DisplayFormatter(maximumCharactersForDisplay: 9)
    private let calculator = Calculator()
    
    // MARK: - Variables
    private var equationResult: Double = 0
    private var queuedNumber: Double = 0
    var operating = false
    private var decimal = false
    var operation: CalculatorEngine.OperationType = .none
    
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
        switch operation {

        case .none:
            return nil
            
        case .addiction:
            equationResult = calculator.execute(equationResult, add: queuedNumber)
            
        case .substraction:
            equationResult = calculator.execute(equationResult, minus: queuedNumber)
            
        case .multiplication:
            equationResult = calculator.execute(equationResult, multiply: queuedNumber)
            
        case .division:
            equationResult = calculator.execute(equationResult, divide: queuedNumber)
        }
        
        operation = .none
        saveSession()
        print("TOTAL: \(equationResult)")
        return equationResult
    }

    // MARK: - Interaction API
    
    mutating func clear() -> Double {
        operation = .none
        queuedNumber = 0
        equationResult = 0
        return equationResult
    }
    
    mutating func negateNumber() -> Double  {
        queuedNumber =  calculator.negate(queuedNumber)
        return queuedNumber
    }
    
    mutating func applyPercentage() -> Double  {
        
        queuedNumber = calculator.decimalPercentage(queuedNumber)
        return queuedNumber
    }
    
    mutating func applyDecimal() -> Double {
        
        decimal = true
        return queuedNumber
    }
    
    // MARK: - Operations
    
    mutating func addOperation() -> Double?  {
        
        guard operation != .addiction else {
            return nil
        }
        
        let displayValue: Double = executeQueuedEquation() ?? queuedNumber
        
        operating = true
        operation = .addiction
        return displayValue
    }
    
    mutating func substractOperation() -> Double? {
        guard operation != .substraction else {
            return nil
        }
        
        let displayValue: Double = executeQueuedEquation() ?? queuedNumber
        operating = true
        operation = .substraction
        return displayValue
    }
    
    mutating func multiplyOperation() -> Double?  {
        guard operation != .multiplication else {
            return nil
        }
        
        let displayValue: Double = executeQueuedEquation() ?? queuedNumber
        operating = true
        operation = .multiplication
        return displayValue
    }
    
    mutating func divideOperation() -> Double?  {
        guard operation != .division else {
            return nil
        }
        let displayValue: Double = executeQueuedEquation() ?? queuedNumber
        operating = true
        operation = .division
        return displayValue
    }
    
    mutating func resultOperation() -> Double? {
        
        let displayNumber = executeQueuedEquation()
        operation = .none
        queuedNumber = equationResult
        
        return displayNumber
    }
    
    // MARK: - Number Entry
    
    mutating func inputNumber(_ number: Int) -> Double {
        
        var currentTemp = displayFormatter.auxTotalFormatter.string(from: NSNumber(value: queuedNumber))!
        if !operating && currentTemp.count >= displayFormatter.maximumCharactersForDisplay { // todo. this code is strange
            return queuedNumber
        }
        
        currentTemp = displayFormatter.auxFormatter.string(from: NSNumber(value: queuedNumber))!
        
        // Hemos seleccionado una operación
        if operating {
            equationResult = equationResult == 0 ? queuedNumber : equationResult
            //resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
        // Hemos seleccionado decimales
        if decimal {
            currentTemp = "\(currentTemp)\(decimalSymbol)"
            decimal = false
        }
        
        // An idea was started below to mathmatically add the values together and remove the strings
        /*
        if decimal {
            
            let numberOfDecimalPlaces = 3 // 0.100
            let numberToAdd = CGFloat(number) / pow(10, (numberOfDecimalPlaces + 1))
            
        } else {
            let newNumber = queuedNumber * 10 + number
        }
         
        */
        
        // TODO we dont want to be creating a string and then converting it to a number
        queuedNumber = Double(currentTemp + String(number))!    // crashes due to force unwrappin the optional
        return queuedNumber
    }
    
    
}

// MARK: - Presentation Logic

extension CalculatorEngine {
    
    func formatForDisplay(number: Double) -> String? {
        return displayFormatter.formatForDisplay(number: number)
    }
}
