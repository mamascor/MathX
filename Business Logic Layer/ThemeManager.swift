//
//  ThemeManager.swift
//  Calc
//
//  Created by Matthew Paul Harding on 27/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//  Tell us what you want to learn  → community@iosbfree.com
// *******************************************************************************************

import Foundation

class ThemeManager {
    
    // MARK: - Properties
    private let dataStore = DataStore(key: "iOSBFree.com.calc.ThemeManager.theme")
    static let shared = ThemeManager()
    
    // MARK: - Theme Options
    private let themes: [CalculatorTheme] = [
    darkTheme,
    electroTheme,
    lightTheme,
    lightBlueTheme,
    pinkTheme,
    darkBlueTheme,
    purpleTheme,
    washedOutTheme,
    vibrantTheme,
    orangeTheme]
    
    // MARK: - Accessing The Current Theme
    private var savedTheme: CalculatorTheme?
    var currentTheme: CalculatorTheme {
        guard let theme = savedTheme else {
            guard let firstThemeOption = themes.first else {
                return darkTheme
            }
            return firstThemeOption
        }
        
        return theme
    }
    
    // MARK: - Initialiser
    init() {
        restoreSavedTheme()
    }
    
    
    // MARK: - Save & Restore From Disk
    private func saveThemeToDisk(_ theme: CalculatorTheme) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(theme) {
            dataStore.set(encoded)
        }
    }
    
    private func restoreSavedTheme() {
        
        if let previousTheme = readSavedThemeFromDisk() {
            savedTheme = previousTheme
        }
    }
    
    private func readSavedThemeFromDisk() -> CalculatorTheme? {
        
        
        guard let savedTheme = dataStore.getValue() as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(CalculatorTheme.self, from: savedTheme)
    }
    
    
    // MARK: - Theme Options
    
    func moveToNextTheme() {
        
        let themeID = currentTheme.id
        let index = themes.firstIndex { calculatorTheme in
            calculatorTheme.id == themeID
        }
        
        guard let indexOfExistingTheme = index else {
            // Nice use of recursion here to re-use our logic and not write any more
            if themes.count > 0 {
                savedTheme = themes.first
                moveToNextTheme()
            }
            
            return
        }
        
        var nextThemeIndex = indexOfExistingTheme + 1
        if nextThemeIndex > themes.count - 1 {
            nextThemeIndex = 0
        }
        
        let nextTheme = themes[nextThemeIndex]
        updateSystemWithTheme(nextTheme)
    }
    
    // MARK: - Set A New Theme
    private func updateSystemWithTheme(_ theme: CalculatorTheme) {
        savedTheme = theme
        saveThemeToDisk(theme)
    }
    
}
