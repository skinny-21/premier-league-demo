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
    func getLeagueTable(completion: @escaping ([LeagueTableTeam]) -> Void)
}

class LeagueTableWorker: LeagueTableWorkerProtocol {

    // MARK: - LeagueTableWorkerProtocol

    var gateway: Gateway?

    func getLeagueTable(completion: @escaping ([LeagueTableTeam]) -> Void) {
        guard let gateway = gateway else {
            completion([])
            return
        }

        gateway.getLeagueTable { (response, _) in
            completion(response?.data.leagueTable ?? [])
        }
    }
}
