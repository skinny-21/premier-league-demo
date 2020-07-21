//
//  LeagueTableInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol LeagueTableBusinessLogic {
    func prepareContent(request: LeagueTable.Content.Request)
}

protocol LeagueTableDataStore: class {
    var gateway: Gateway? { get set }
}

class LeagueTableInteractor: LeagueTableBusinessLogic, LeagueTableDataStore {

    // MARK: - LeagueTableDataStore

    var gateway: Gateway?

    // MARK: - Internal properties

    var presenter: LeagueTablePresentationLogic?
    var worker: LeagueTableWorkerProtocol?

    // MARK: - Initialization

    init(worker: LeagueTableWorkerProtocol = LeagueTableWorker()) {
        self.worker = worker
    }

    // MARK: - LeagueTableBusinessLogic

    func prepareContent(request: LeagueTable.Content.Request) {
        worker?.gateway = gateway
        worker?.getLeagueTable(completion: { [weak self] (leagueTable) in
            let sortedLeagueTable = leagueTable.sorted { $0.position < $1.position }
            let response = LeagueTable.Content.Response(leagueTable: sortedLeagueTable)
            self?.presenter?.presentContent(response: response)
        })
    }
}
