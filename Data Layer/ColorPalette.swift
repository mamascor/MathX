//
//  ColorPalette.swift
//  Calc
//
//  Created by Matthew Paul Harding on 24/01/2022.
//

import Foundation

enum StatusBarStyle {
    case light
    case dark
}

protocol ColorPalette {
    
    var background: String { get }
    var display: String { get }
    
    var operatorNormal: String { get }
    var operatorSelected: String { get }
    
    var operatorTitle: String { get }
    var operatorTitleSelected: String { get }
    
    var pinPad: String { get }
    var pinPadTitle: String { get }
    
    var extraFunctions: String { get }
    var extraFunctionsTitle: String { get }
    
    var statusBarStyle: StatusBarStyle { get }
}
