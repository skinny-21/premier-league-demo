//
//  LeagueTableData.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct LeagueTableData: Decodable {
    let leagueTable: [LeagueTableTeamResponse]
    
    enum CodingKeys: String, CodingKey {
        case leagueTable = "league_table"
    }
}
