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
