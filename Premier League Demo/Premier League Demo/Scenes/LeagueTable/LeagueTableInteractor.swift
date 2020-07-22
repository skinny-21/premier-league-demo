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
    func getTeamImage(request: LeagueTable.TeamImage.Request)
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

    // MARK: - Private properties

    private var leagueTable = [LeagueTable.TeamModel]()

    // MARK: - Initialization

    init(worker: LeagueTableWorkerProtocol = LeagueTableWorker()) {
        self.worker = worker
    }

    // MARK: - LeagueTableBusinessLogic

    func prepareContent(request: LeagueTable.Content.Request) {
        worker?.gateway = gateway
        worker?.getLeagueTable(completion: { [weak self] (leagueTable) in
            guard let self = self else { return }
            self.leagueTable = leagueTable.sorted { $0.position < $1.position }
            let response = LeagueTable.Content.Response(leagueTable: self.leagueTable)
            self.presenter?.presentContent(response: response)
        })
    }

    func getTeamImage(request: LeagueTable.TeamImage.Request) {
        guard leagueTable.indices.contains(request.index), let imageURL = leagueTable[request.index].imageURL else {
            return
        }

        worker?.getImage(url: imageURL, completion: { [weak self] data in
            let response = LeagueTable.TeamImage.Response(index: request.index, imageData: data)
            self?.presenter?.presentTeamImage(response: response)
        })
    }
}
