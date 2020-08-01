//
//  PlayerDetailsRouter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol PlayerDetailsRoutingLogic {
    func close()
}

protocol PlayerDetailsDataPassing {
    var dataStore: PlayerDetailsDataStore? { get }
}

class PlayerDetailsRouter: PlayerDetailsRoutingLogic, PlayerDetailsDataPassing {

    // MARK: - Internal properties

    weak var viewController: PlayerDetailsViewController?

    // MARK: - PlayerDetailsDataPassing

    var dataStore: PlayerDetailsDataStore?

    // MARK: - PlayerDetailsRoutingLogic

    func close() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
