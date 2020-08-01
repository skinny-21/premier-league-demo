//
//  TeamStatsData.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct TeamStatsData: Decodable {
    let lastMatchesCount: Int
    let name: String
    let id: Int
    let stats: [String: Stat]

    enum CodingKeys: String, CodingKey {
        case lastMatchesCount = "last_x_match_num"
        case name
        case id
        case stats
    }
}
