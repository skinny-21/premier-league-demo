//
//  LeagueTableResponseMocks.swift
//  Premier League DemoTests
//
//  Created by Wojciech Woźniak on 05/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

extension LeagueTableResponse {
    static var someListMock: LeagueTableResponse {
        let liverpool = LeagueTableTeamResponse(id: 1, position: 1, seasonGoals: 85, points: 99, seasonGoalDifference: 52, matchesPlayed: 38, name: "Liverpool FC", cleanName: "Liverpool", url: "/clubs/england/liverpool-fc")

        let manCity = LeagueTableTeamResponse(id: 2, position: 2, seasonGoals: 102, points: 81, seasonGoalDifference: 67, matchesPlayed: 38, name: "Manchester City FC", cleanName: "Manchester City", url: "/clubs/england/manchester-city-fc")


        return LeagueTableResponse(data: LeagueTableData(leagueTable: [manCity, liverpool]))
    }

    static var emptyListMock: LeagueTableResponse {
        LeagueTableResponse(data: LeagueTableData(leagueTable: []))
    }
}
