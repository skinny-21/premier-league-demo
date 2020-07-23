//
//  LocalStorage.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 23/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

protocol LocalStorage {
    func saveToFavourites(id: Int, isFavourite: Bool)
    func isFavourite(id: Int) -> Bool
}
