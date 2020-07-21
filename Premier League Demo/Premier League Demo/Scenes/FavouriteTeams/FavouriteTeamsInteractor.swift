//
//  FavouriteTeamsInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol FavouriteTeamsBusinessLogic {

}

protocol FavouriteTeamsDataStore {

}

class FavouriteTeamsInteractor: FavouriteTeamsBusinessLogic, FavouriteTeamsDataStore {

    // MARK: - DataStore

    // MARK: - FavouriteTeamsDataStore

    // MARK: - Internal properties

    var presenter: FavouriteTeamsPresentationLogic?
    var worker: FavouriteTeamsWorkerProtocol?

    // MARK: - Initialization

    init(worker: FavouriteTeamsWorkerProtocol = FavouriteTeamsWorker()) {
        self.worker = worker
    }

    // MARK: - FavouriteTeamsBusinessLogic

}
