//
//  PinkCalculatorTheme.swift
//  MathX



import Foundation

extension ThemeManager {
    
    var pinkTheme: CalculatorTheme {
        CalculatorTheme(id:"5",
        background:             "#253C5B",
        display:                "#EBF0EF",
        operatorNormal:         "#FA569C",
        operatorSelected:       "#0265FF",
        operatorTitle:          "#EBF0EF",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#16253A",
        pinPadTitle:            "#EBF0EF",
        extraFunctions:         "#294666",
        extraFunctionsTitle:    "#EBF0EF",
        statusBarStyle: .light)
    }
}
