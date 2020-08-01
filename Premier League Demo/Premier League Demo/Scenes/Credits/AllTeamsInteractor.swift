//
//  CreditsInteractor.swift
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

class CreditsInteractor: AllTeamsBusinessLogic, AllTeamsDataStore {

    // MARK: - AllTeamsDataStore

    // MARK: - Internal properties

    var presenter: AllTeamsPresentationLogic?

    // MARK: - Initialization

    init() {}

    // MARK: - AllTeamsBusinessLogic

}
