//
//  MathEquation.swift
//  MathX



import Foundation

struct MathEquation: Codable {
    
    // MARK: - Operation Enum
    
    enum OperationType: String, Codable {
        case add = "add"
        case subtract = "subtract"
        case divide = "divide"
        case multiply  = "multiply"
    }
    
    // MARK: - Variables
    
    var lhs: Decimal = 0
    var rhs: Decimal?
    var operation: OperationType?
    var result: Decimal?
    
    var executed: Bool {
        return result != nil
    }
    
    // MARK: - Equation Math
    
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
    
    mutating func negateLeftHandSide() {
        lhs.negate()
    }
    
    mutating func negateRightHandSide() {
        rhs?.negate()
    }
    
    mutating func applyPercentageToLeftHandSide() {
        lhs = calculatePercentageValue(lhs)
    }
    
    mutating func applyPercentageToRightHandSide() {
        rhs = calculatePercentageValue(rhs)
    }

    private func calculatePercentageValue(_ decimal: Decimal?) -> Decimal {
        guard let decimal = decimal else { return .nan }
        return  decimal / 100
    }
    
    // MARK: - Visual Representations
    
    func generatePrintout() -> String {
        let operatorString = generateStringRepresentationOfOperator()
        return lhs.formatted() + " " + operatorString + " " + (rhs?.formatted() ?? "") + " = " + (result?.formatted() ?? "")
    }
    
    func generateStringRepresentationOfOperator() -> String {
        switch operation {
        case .multiply: return "*"
        case .divide: return "/"
        case .add: return "+"
        case .subtract: return "-"
        case .none:
            return ""
        }
    }
}
