//
//  LeagueTableInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol LeagueTableBusinessLogic {

}

protocol LeagueTableDataStore {

}

class LeagueTableInteractor: LeagueTableBusinessLogic, LeagueTableDataStore {

    // MARK: - DataStore

    // MARK: - LeagueTableDataStore

    // MARK: - Internal properties

    var presenter: LeagueTablePresentationLogic?
    var worker: LeagueTableWorkerProtocol?

    // MARK: - Initialization

    init(worker: LeagueTableWorkerProtocol = LeagueTableWorker()) {
        self.worker = worker
    }

    // MARK: - LeagueTableBusinessLogic
    
}
