//
//  Gateway.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

protocol Gateway {
    func getLeagueTable(completionHandler: @escaping ResponseHandler<LeagueTableResponse>)
    func getImage(url: URL, completionHandler: @escaping ResponseHandler<Data>)
    func getTeamStats(teamId: Int, completionHandler: @escaping ResponseHandler<TeamStatsResponse>)
}
