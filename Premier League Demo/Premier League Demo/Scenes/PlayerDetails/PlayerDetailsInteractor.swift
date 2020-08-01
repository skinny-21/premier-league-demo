//
//  PlayerDetailsInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol PlayerDetailsBusinessLogic {
    func prepareContent(request: PlayerDetails.Content.Request)
}

protocol PlayerDetailsDataStore: class {
    var player: Player? { get set }
}

class PlayerDetailsInteractor: PlayerDetailsBusinessLogic, PlayerDetailsDataStore {

    // MARK: - PlayerDetailsDataStore

    var player: Player?

    // MARK: - Internal properties

    var presenter: PlayerDetailsPresentationLogic?

    // MARK: - Initialization

    init() {}

    // MARK: - PlayerDetailsBusinessLogic

    func prepareContent(request: PlayerDetails.Content.Request) {
        presenter?.presentContent(response: PlayerDetails.Content.Response(player: player))
    }
}
