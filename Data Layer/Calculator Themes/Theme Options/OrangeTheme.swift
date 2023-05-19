//
//  OrangeCalculatorTheme.swift
//  MathX


import Foundation

extension ThemeManager {
    
    var orangeTheme: CalculatorTheme {
        CalculatorTheme(id:"10",
        background:             "#DC6969",
        display:                "#ffffff",
        operatorNormal:         "#CC4D4D",
        operatorSelected:       "#AB2F2F",
        operatorTitle:          "#ffffff",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#C94848",
        pinPadTitle:            "#ffffff",
        extraFunctions:         "#D05353",
        extraFunctionsTitle:    "#ffffff",
        statusBarStyle: .light)
    }
}
