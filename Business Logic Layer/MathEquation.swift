//
//  MathEquation.swift
//  Calc
//
//  Created by Matthew Paul Harding on 26/01/2022.
//

import Foundation

struct MathEquation {
    
    // MARK: - Operation Enum
    enum OperationType {
        case add
        case subtract
        case divide
        case multiply   // Todo add .none and remove the optionals associated with properties
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
    
    var printout: String {
        
        let operatorString = stringRepresentationOfOperator
        return lhs.formatted() + " " + operatorString + " " + (rhs?.formatted() ?? "") + " = " + (result?.formatted() ?? "")
    }
    
    var stringRepresentationOfOperator: String {
        
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
