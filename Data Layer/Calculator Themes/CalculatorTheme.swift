//
//  CalculatorTheme.swift
//  MathX



import Foundation

enum StatusBarStyle: String, Codable {
    case light = "light"   
    case dark = "dark"
}

struct CalculatorTheme: Codable {
    var id: String
    var background: String
    var display: String
    
    var operatorNormal: String
    var operatorSelected: String
    
    var operatorTitle: String
    var operatorTitleSelected: String
    
    var pinPad: String
    var pinPadTitle: String
    
    var extraFunctions: String
    var extraFunctionsTitle: String
    
    var statusBarStyle: StatusBarStyle
}
