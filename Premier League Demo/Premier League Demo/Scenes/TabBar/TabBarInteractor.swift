//
//  TabBarInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TabBarBusinessLogic {

}

protocol TabBarDataStore {

}

class TabBarInteractor: TabBarBusinessLogic, TabBarDataStore {

    // MARK: - DataStore

    // MARK: - TabBarDataStore

    // MARK: - Internal properties

    var presenter: TabBarPresentationLogic?
    var worker: TabBarWorkerProtocol?

    // MARK: - Initialization

    init(worker: TabBarWorkerProtocol = TabBarWorker()) {
        self.worker = worker
    }

    // MARK: - TabBarBusinessLogic

}
