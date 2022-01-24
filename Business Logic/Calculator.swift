//
//  Calculator.swift
//  Calc
//
//  Created by Matthew Paul Harding on 23/01/2022.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
//

import Foundation

struct Calculator {
    
    // MARK: - Basic Math DMAS
    
    func execute(_ lhd: Double, add rhd: Double) -> Double {
        return lhd + rhd
    }
    
    func execute(_ lhd: Double, minus rhd: Double) -> Double {
        return lhd - rhd
    }
    
    func execute(_ lhd: Double, multiply rhd: Double) -> Double {
        return lhd * rhd
    }
    
    func execute(_ lhd: Double, divide rhd: Double) -> Double {
        return lhd / rhd
    }
    
    // MARK: - Altering 1 Value
    
    func negate(_ number: Double) -> Double  {
        return number * (-1)
    }
    
    func decimalPercentage(_ number: Double) -> Double  {
        return number / 100
    }
}
