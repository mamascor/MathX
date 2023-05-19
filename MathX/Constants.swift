//
//  Constants.swift
//  MathX


import Foundation
import UIKit

// MARK: - LCDDisplay

extension LCDDisplay {
    struct keys {
        static let pasteNumberNotification = "iOSBFree.com.calc.LCDDisplay.pasteNumber"
        static let pasteEquationNotification = "iOSBFree.com.calc.LCDDisplay.pasteMathEquation"
        static let userInfo = "valueToPaste"
        static let historyLogNotification = "iOSBFree.com.calc.LCDDisplay.displayHistory"
    }
}

// MARK: - UIStoryboard

extension UIStoryboard {
    struct keys {
        static let mainStoryboard = "Main"
        static let logViewController = "LogViewController"
    }
}

// MARK: - UIImage

extension UIImage {
    struct keys {
        static let circle = "Circle"
        static let circleSliced = "Circle-Sliced"
    }
}

// MARK: - ThemeManager

extension ThemeManager {
    struct keys {
        static let dataStore = "iOSBFree.com.calc.ThemeManager.theme"
    }
}

// MARK: - iOSBFreeCalculatorEngine

extension iOSBFreeCalculatorEngine {
    struct keys {
        static let dataStore = "iOSBFree.com.calc.CalculatorEngine.total"
    }
}
