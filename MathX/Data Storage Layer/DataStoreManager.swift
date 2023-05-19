//
//  DataStoreManager.swift
//  MathX



import Foundation

struct DataStoreManager {
    
    // MARK: - Unique Key
    
    let key: String
    
    // MARK: - Storing Data
    
    func set(_ value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValue() -> Any? {
        UserDefaults.standard.object(forKey: key)
    }
    
    // MARK: - Deleting Data
    
    func deleteValue() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
