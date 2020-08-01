//
//  Player.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct Player: Decodable {
    let clubTeamID: Int
    let fullName: String
    let position: PlayerPosition
    let age: Int
    let height: Int
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case clubTeamID = "club_team_id"
        case fullName = "full_name"
        case position
        case age
        case height
        case weight
    }
}
