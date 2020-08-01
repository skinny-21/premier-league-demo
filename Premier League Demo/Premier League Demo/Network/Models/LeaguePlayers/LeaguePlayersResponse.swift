//
//  LeaguePlayersResponse.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct LeaguePlayersResponse: Decodable {
    let pager: Pager
    let data: [Player]
}
