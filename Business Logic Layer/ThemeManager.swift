//
//  ThemeManager.swift
//  MathX



import Foundation

class ThemeManager {
    
    // MARK: - Properties
    
    private let dataStore = DataStoreManager(key: ThemeManager.keys.dataStore)
    
    // MARK: - 👇🏽 The Singleton Design Pattern
    
    static let shared = ThemeManager() // → 💡 Singletons: We use the singleton design pattern here because we want only 1 ThemeManager to exist
    
    // MARK: - Theme Options
    
    private(set) var themes: [CalculatorTheme] = []
    
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
        populateSelectionOfThemes()
    }
    
    // MARK: - Populate Theme Selection
    
    private func populateSelectionOfThemes() {
        themes = [darkTheme, purpleTheme, orangeTheme, lightTheme, pinkTheme, lightBlueTheme, electroTheme, washedOutTheme, bloodOrangeTheme, darkBlueTheme]
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
    
    // MARK: - Changing Themes
    
    func moveToNextTheme() {
        let themeID = currentTheme.id
        let index = themes.firstIndex { calculatorTheme in
            calculatorTheme.id == themeID
        }
        
        // → The user is using a theme which has been removed. Reset to the first theme.
        guard let indexOfExistingTheme = index else {
            if let firstTheme = themes.first {
                updateSystemWithTheme(firstTheme)
            }
            return
        }
        
        // → Move to the next theme
        var nextThemeIndex = indexOfExistingTheme + 1
        if nextThemeIndex > themes.count - 1 {
            nextThemeIndex = 0
        }
        guard let nextTheme = themes[safe: nextThemeIndex] else {
            return
        }
        
        updateSystemWithTheme(nextTheme)
    }
    
    // MARK: - Set A New Theme
    
    private func updateSystemWithTheme(_ theme: CalculatorTheme) {
        savedTheme = theme
        saveThemeToDisk(theme)
    }
}
