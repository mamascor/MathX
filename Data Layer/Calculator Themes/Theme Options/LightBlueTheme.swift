//
//  LightBlueCalculatorTheme.swift
//  MathX


import Foundation

extension ThemeManager {
    
    var lightBlueTheme: CalculatorTheme {
        CalculatorTheme(id:"4",
        background:             "#F8F8F8",
        display:                "#000000",
        operatorNormal:         "#00B4FF",
        operatorSelected:       "#0265FF",
        operatorTitle:          "#ffffff",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#EEEEEE",
        pinPadTitle:            "#000000",
        extraFunctions:         "#D6DEE5",
        extraFunctionsTitle:    "#00B4FF",
        statusBarStyle: .dark)
    }
}
