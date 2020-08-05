//
//  GatewayMock.swift
//  Premier League DemoTests
//
//  Created by Wojciech Woźniak on 05/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

class GatewayMock: Gateway {
    private(set) var getLeagueTableCallsCount = 0
    var getLeagueTableResponse: LeagueTableResponse?
    func getLeagueTable(completionHandler: @escaping ResponseHandler<LeagueTableResponse>) {
        getLeagueTableCallsCount += 1
        completionHandler(getLeagueTableResponse, nil)
    }

    private(set) var getImageCallsCount = 0
    func getImage(url: URL, completionHandler: @escaping ResponseHandler<Data>) {
        getImageCallsCount += 1
    }

    private(set) var getTeamStatsCallsCount = 0
    func getTeamStats(teamId: Int, completionHandler: @escaping ResponseHandler<TeamStatsResponse>) {
        getTeamStatsCallsCount += 1
    }

    private(set) var getLeaguePlayersCallsCount = 0
    func getLeaguePlayers(page: Int, completionHandler: @escaping ResponseHandler<LeaguePlayersResponse>) {
        getLeaguePlayersCallsCount += 1
    }
}
