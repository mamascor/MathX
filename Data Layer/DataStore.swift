//
//  DataStore.swift
//  Calc
//
//  Created by Matthew Paul Harding on 01/01/22.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
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

struct DataStore {
    
    let key: String
    
    func saveResult(_ number: Double) {
        UserDefaults.standard.set(number, forKey: key)
    }
    
    func loadResult() -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    
    func saveDecimal(_ decimal: Decimal) {
        UserDefaults.standard.set(decimal.doubleValue, forKey: key)
    }
    
    func loadDecimal() -> Decimal {
        return Decimal(UserDefaults.standard.double(forKey: key))
    }
    
    func saveInt(_ number: Int) {
        return UserDefaults.standard.set(number, forKey: key)
    }
    
    func loadInt() -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    func removeValue() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

private extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
