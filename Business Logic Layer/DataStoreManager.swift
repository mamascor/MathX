//
//  DataStoreManager.swift
//  Calc
//
//  Created by iOSB Free on 01/01/22.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏿 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💜 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's a data access manager, a simple wrapper for User Defaults.
//   Architecural Layer: Business Logic Layer
//
//   💡 Architecture Tip 👉🏻 We disconnect where the data is stored by creating this wrapper.
// *******************************************************************************************


import Foundation

struct DataStoreManager {
    
    let key: String
    
    func set(_ value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValue() -> Any? {
        UserDefaults.standard.object(forKey: key)
    }
}
