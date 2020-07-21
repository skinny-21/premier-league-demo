//
//  LeagueTableTeam.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct LeagueTableTeam: Decodable {
    let id: Int
    let position: Int
    let seasonGoals: Int
    let points: Int
    let seasonGoalDifference: Int
    let matchesPlayed: Int
    let name: String
    let cleanName: String
    let url: String
}
