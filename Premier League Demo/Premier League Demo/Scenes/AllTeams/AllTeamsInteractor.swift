//
//  AllTeamsInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol AllTeamsBusinessLogic {

}

protocol AllTeamsDataStore {

}

class AllTeamsInteractor: AllTeamsBusinessLogic, AllTeamsDataStore {

    // MARK: - DataStore

    // MARK: - AllTeamsDataStore

    // MARK: - Internal properties

    var presenter: AllTeamsPresentationLogic?
    var worker: AllTeamsWorkerProtocol?

    // MARK: - Initialization

    init(worker: AllTeamsWorkerProtocol = AllTeamsWorker()) {
        self.worker = worker
    }

    // MARK: - AllTeamsBusinessLogic

}
