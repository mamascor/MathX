//
//  WashedOutCalculatorTheme.swift
//  MathX



import Foundation

extension ThemeManager {
    
    var washedOutTheme: CalculatorTheme {
        CalculatorTheme(id:"8",
        background:             "#ECF5FF",
        display:                "#0D2A4B",
        operatorNormal:         "#A3CFF9",
        operatorSelected:       "#0D2A4B",
        operatorTitle:          "#5487BA",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#1D1D1D",
        pinPadTitle:            "#ffffff",
        extraFunctions:         "#A3CFF9",
        extraFunctionsTitle:    "#5487BA",
        statusBarStyle: .dark)
    }
}
