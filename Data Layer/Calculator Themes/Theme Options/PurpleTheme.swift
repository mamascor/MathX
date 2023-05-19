//
//  PurpleCalculatorTheme.swift
//  MathX



import Foundation

extension ThemeManager {
    
    var purpleTheme: CalculatorTheme {
        CalculatorTheme(id:"7",
        background:             "#F4F5FA",
        display:                "#1D1D1D",
        operatorNormal:         "#7550FE",
        operatorSelected:       "#4566B6",
        operatorTitle:          "#ffffff",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#1D1D1D",
        pinPadTitle:            "#ffffff",
        extraFunctions:         "#F4F5FA",
        extraFunctionsTitle:    "#7550FE",
        statusBarStyle: .dark)
    }
}
