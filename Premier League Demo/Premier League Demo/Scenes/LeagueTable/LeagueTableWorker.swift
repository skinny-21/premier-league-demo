//
//  LeagueTableWorker.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol LeagueTableWorkerProtocol {
    var gateway: Gateway? { get set }
    func getLeagueTable(completion: @escaping ([LeagueTable.TeamModel]) -> Void)
    func getImage(url: URL, completion: @escaping (Data?) -> Void)
}

class LeagueTableWorker: LeagueTableWorkerProtocol {

    // MARK: - LeagueTableWorkerProtocol

    var gateway: Gateway?

    func getLeagueTable(completion: @escaping ([LeagueTable.TeamModel]) -> Void) {
        guard let gateway = gateway else {
            completion([])
            return
        }

        gateway.getLeagueTable { (response, _) in
            guard let leagueTable = response?.data.leagueTable else {
                completion([])
                return
            }

            let teamsModels: [LeagueTable.TeamModel] = leagueTable.map {
                let cdnURL = URL(string: "https://cdn.footystats.org/img/teams")
                let imagePath = $0.url.split(separator: "/").suffix(2).joined(separator: "-").appending(".png")
                let imageURL = cdnURL?.appendingPathComponent(imagePath)
                return LeagueTable.TeamModel(id: $0.id,
                                             position: $0.position,
                                             seasonGoals: $0.seasonGoals,
                                             points: $0.points,
                                             seasonGoalDifference: $0.seasonGoalDifference,
                                             matchesPlayed: $0.matchesPlayed,
                                             name: $0.name,
                                             cleanName: $0.cleanName,
                                             imageURL: imageURL)
            }
            completion(teamsModels)
        }
    }

    func getImage(url: URL, completion: @escaping (Data?) -> Void) {
        guard let gateway = gateway else {
            completion(nil)
            return
        }

        gateway.getImage(url: url) { (data, _) in
            completion(data)
        }
    }
}
