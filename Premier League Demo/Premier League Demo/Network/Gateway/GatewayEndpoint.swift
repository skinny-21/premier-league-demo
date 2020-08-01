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
    #warning("TODO: remove teamDetails")
    case teamDetails(teamId: Int)
    case teamStats(teamId: Int)
    case leaguePlayers(page: Int)

    var path: String {
        switch self {
        case .leagueTable: return "league-tables"
        case .teamDetails: return "team"
        case .teamStats: return "lastx"
        case .leaguePlayers: return "league-players"
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .leagueTable:
            return nil
        case .teamDetails(let teamId):
            return [URLQueryItem(name: "team_id", value: "\(teamId)")]
        case .teamStats(let teamId):
            return [URLQueryItem(name: "team_id", value: "\(teamId)"),
                    URLQueryItem(name: "last_x_match_num", value: "3")]
        case .leaguePlayers(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        }
    }
}
