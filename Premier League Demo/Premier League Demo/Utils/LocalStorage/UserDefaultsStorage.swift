//
//  UserDefaultsStorage.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 23/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

class UserDefaultsStorage: LocalStorage {
    let userDefaults = UserDefaults.standard

    func saveToFavourites(id: Int, isFavourite: Bool){
        userDefaults.setValue(isFavourite, forKey: "\(id)")
        userDefaults.synchronize()
    }

    func isFavourite(id: Int) -> Bool {
        return userDefaults.bool(forKey: "\(id)")
    }
}
