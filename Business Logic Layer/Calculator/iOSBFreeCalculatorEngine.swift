//
//  iOSBFreeCalculatorEngine.swift
//  MathX



import Foundation

struct iOSBFreeCalculatorEngine {
    
    // MARK: - Variables
    
    private var historyLog: [MathEquation] = []
    private var currentMathEntry = MathInputController()
    
    // MARK: - Managers
    
    private let dataStore = DataStoreManager(key: iOSBFreeCalculatorEngine.keys.dataStore)
    
    // MARK: - Display
    
    var lcdDisplayText: String {
        currentMathEntry.lcdDisplayText
    }
    
    // MARK: - Properties For Testing
    
    var leftHandOperand: Decimal {
        currentMathEntry.lhs
    }
    
    var rightHandOperand: Decimal? {
        currentMathEntry.rhs
    }
    
    var resultOfEquation: Decimal? {
        currentMathEntry.result
    }
    
    // MARK: - Interaction API
    
    var copyOfEquationLog: [MathEquation] {
        historyLog
    }
    
    mutating func clearHistory() {
        historyLog = []
    }
    
    mutating func clearPressed() {
        currentMathEntry = MathInputController()
        deleteSavedSession()
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
            currentMathEntry = MathInputController()
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
            var newMathEntry = MathInputController()
            newMathEntry.lhs = currentMathEntry.result ?? Decimal.zero
            newMathEntry.operation = currentMathEntry.operation
            newMathEntry.rhs = currentMathEntry.rhs
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
        printEquationToDebugConsole(currentMathEntry)
        saveSession()
    }
    
    // MARK: - Print To Console
    
    private func printEquationToDebugConsole(_ mathInputController: MathInputController) {
        // → Using the print command only works in debug mode
        print(mathInputController.generatePrintout)
    }
    
    // MARK: - Number Entry
    
    mutating func numberPressed(_ number: Int) {
        // → Only accept values from the numeric keypad -9..9
        guard number <= 9,
        number >= -9 else { return }
        
        if currentMathEntry.isCompleted {
            currentMathEntry = MathInputController()
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
        var newMathEntry = MathInputController()
        newMathEntry.lhs = currentMathEntry.result ?? Decimal(0)
        
        if continueEditingResult == false {
            newMathEntry.startEditingRightHandSide()
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
        
        var newMathEntry = MathInputController()
        newMathEntry.lhs = Decimal(1)
        newMathEntry.multiply()
        newMathEntry.rhs = lastExecutedResult
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
    
    private func deleteSavedSession() {
        dataStore.deleteValue()
    }
    
    private func isMathEntrySafeToBeSaved(_ mathEntry: MathInputController) -> Bool {
        guard mathEntry.containsNans == false,  // → crashes when encoding nans
              let _ = mathEntry.result,
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
    
    // → 💡 Just a thought: Adding system features like copy & paste provides a nicer experience for the user.
    
    mutating func pasteInNumber(from decimal: Decimal) {
        if currentMathEntry.isCompleted {
            currentMathEntry = MathInputController()
        }
        
        currentMathEntry.pasteIn(decimal)
    }
    
    mutating func pasteInNumber(from mathEquation: MathEquation) {
        guard let result = mathEquation.result else {
            return
        }
        
        currentMathEntry = MathInputController()
        pasteInNumber(from: result)
    }
}
