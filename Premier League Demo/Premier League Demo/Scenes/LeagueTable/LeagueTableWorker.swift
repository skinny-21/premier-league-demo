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
    func getLeagueTable(completion: @escaping ([TeamModel]) -> Void)
    func getImage(url: URL, completion: @escaping (Data?) -> Void)
    func toggleFavouriteTeam(id: Int, isFavourite: Bool) -> Bool
}

class LeagueTableWorker: LeagueTableWorkerProtocol {
    var gateway: Gateway?
    private let localStorage: LocalStorage

    init(localStorage: LocalStorage = UserDefaultsStorage()) {
        self.localStorage = localStorage
    }

    func getLeagueTable(completion: @escaping ([TeamModel]) -> Void) {
        guard let gateway = gateway else {
            completion([])
            return
        }

        gateway.getLeagueTable { [weak self] (response, _) in
            guard let self = self else { return }

            guard let leagueTable = response?.data.leagueTable else {
                completion([])
                return
            }

            let teamsModels: [TeamModel] = leagueTable.map {
                let cdnURL = URL(string: "https://cdn.footystats.org/img/teams")
                let imagePath = $0.url.split(separator: "/").suffix(2).joined(separator: "-").appending(".png")
                let imageURL = cdnURL?.appendingPathComponent(imagePath)
                return TeamModel(id: $0.id,
                                 position: $0.position,
                                 seasonGoals: $0.seasonGoals,
                                 points: $0.points,
                                 seasonGoalDifference: $0.seasonGoalDifference,
                                 matchesPlayed: $0.matchesPlayed,
                                 name: $0.name,
                                 cleanName: $0.cleanName,
                                 isFavourite: self.localStorage.isFavourite(id: $0.id),
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

    func toggleFavouriteTeam(id: Int, isFavourite: Bool) -> Bool {
        let isFavouriteUpdated = !isFavourite
        localStorage.saveToFavourites(id: id, isFavourite: isFavouriteUpdated)
        return isFavouriteUpdated
    }
}
