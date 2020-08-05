//
//  LocalStorageMock.swift
//  Premier League DemoTests
//
//  Created by Wojciech Woźniak on 05/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

class LocalStorageMock: LocalStorage {
    var favourites = [Int: Bool]()

    func saveToFavourites(id: Int, isFavourite: Bool) {
        favourites[id] = isFavourite
    }

    func isFavourite(id: Int) -> Bool {
        favourites[id, default: false]
    }
}
