//
//  DarkBlueCalculatorTheme.swift
//  MathX



import Foundation

extension ThemeManager {
    
    var darkBlueTheme: CalculatorTheme {
        CalculatorTheme(id:"6",
        background:              "#1D1D1D",
        display:                "#727272",
        operatorNormal:         "#4566B6",
        operatorSelected:       "#4566B6",
        operatorTitle:          "#ffffff",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#1D1D1D",
        pinPadTitle:            "#767676",
        extraFunctions:         "#323232",
        extraFunctionsTitle:    "#FFFFFF",
        statusBarStyle: .light)
    }
}
