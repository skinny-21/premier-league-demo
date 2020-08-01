//
//  GatewayEndpoint.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

enum GatewayEndpoint {
    case leagueTable
    case teamDetails(teamId: Int)

    var path: String {
        switch self {
        case .leagueTable: return "league-tables"
        case .teamDetails: return "team"
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .leagueTable:
            return nil
        case .teamDetails(let teamId):
            return [URLQueryItem(name: "team_id", value: "\(teamId)")]
        }
    }
}
