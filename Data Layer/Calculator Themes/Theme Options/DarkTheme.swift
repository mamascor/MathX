//
//  DarkCalculatorTheme.swift
//  MathX



import Foundation

extension ThemeManager {
    
    var darkTheme: CalculatorTheme {
        CalculatorTheme(id:"1",
        background:             "#000000",
        display:                "#ffffff",
        operatorNormal:         "#ff9f0a",
        operatorSelected:       "#ffffff",
        operatorTitle:          "#ffffff",
        operatorTitleSelected:  "#ff9f0a",
        pinPad:                 "#333333",
        pinPadTitle:            "#ffffff",
        extraFunctions:         "#a6a6a6",
        extraFunctionsTitle:    "#000000",
        statusBarStyle: .light)
    }
}
