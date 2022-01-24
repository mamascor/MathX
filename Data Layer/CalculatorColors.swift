//
//  CalculatorColors.swift
//  Calc
//
//  Created by Matthew Paul Harding on 24/01/2022.
//

import Foundation

protocol CalculatorColors {
    
    var background: String { get }
    var display: String { get }
    
    var operand: String { get }
    var operandHighlighted: String { get }
    var operandSelected: String { get }
    
    var operatorTitle: String { get }
    var operatorTitleHighlighted: String { get }
    var operatorTitleSelected: String { get }
    
    var pinPad: String { get }
    var pinPadHighlighted: String { get }
    
    var pinPadTitle: String { get }
    var pinPadTitleHighlighted: String { get }
    
    var extraFunctions: String { get }
    var extraFunctionsHighlighted: String { get }
    
    var extraFunctionsTitle: String { get }
    var extraFunctionsTitleHighlighted: String { get }
}
