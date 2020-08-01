//
//  PlayerPosition.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

enum PlayerPosition: String, Decodable {
    case defender = "Defender"
    case forward = "Forward"
    case goalkeeper = "Goalkeeper"
    case midfielder = "Midfielder"
}

extension PlayerPosition {
    var positionOrder: Int {
        switch self {
        case .goalkeeper: return 0
        case .defender: return 1
        case .midfielder: return 2
        case .forward: return 3
        }
    }
}

extension PlayerPosition: Comparable {
    static func < (lhs: PlayerPosition, rhs: PlayerPosition) -> Bool {
        lhs.positionOrder < rhs.positionOrder
    }
}
