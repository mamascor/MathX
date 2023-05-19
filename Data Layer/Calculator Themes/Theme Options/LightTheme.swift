//
//  LightCalculatorTheme.swift
//  MathX


import Foundation

extension ThemeManager {
    
    var lightTheme: CalculatorTheme {
        CalculatorTheme(id:"3",
        background:             "#F6F8F9",
        display:                "#000000",
        operatorNormal:         "#4BE6A9",
        operatorSelected:       "#70729D",
        operatorTitle:          "#14145C",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#E9F0F4",
        pinPadTitle:            "#000000",
        extraFunctions:         "#E9F0F4",
        extraFunctionsTitle:    "#4BE6A9",
        statusBarStyle: .dark)
    }
}
