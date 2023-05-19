//
//  ElectroCalculatorTheme.swift
//  MathX


import Foundation

extension ThemeManager {
    
    var electroTheme: CalculatorTheme {
        CalculatorTheme(id:"2",
        background:             "#0E0E41",
        display:                "#ffffff",
        operatorNormal:         "#4BE6A9",
        operatorSelected:       "#70729D",
        operatorTitle:          "#14145C",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#14145C",
        pinPadTitle:            "#ffffff",
        extraFunctions:         "#14145C",
        extraFunctionsTitle:    "#4BE6A9",
        statusBarStyle: .light)
    }
}
