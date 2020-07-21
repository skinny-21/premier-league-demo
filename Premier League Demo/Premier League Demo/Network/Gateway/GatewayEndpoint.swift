//
//  GatewayEndpoint.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

enum GatewayEndpoint: String {
    case leagueTable = "league-tables"
    case teamDetails = "team"

    var path: String {
        rawValue
    }
}
