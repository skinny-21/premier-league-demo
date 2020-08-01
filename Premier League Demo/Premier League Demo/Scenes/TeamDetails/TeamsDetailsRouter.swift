//
//  TeamDetailsRouter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 31/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TeamDetailsRoutingLogic {

}

protocol TeamDetailsDataPassing {
    var dataStore: TeamDetailsDataStore? { get }
}

class TeamDetailsRouter: TeamDetailsRoutingLogic, TeamDetailsDataPassing {

    // MARK: - Internal properties

    weak var viewController: TeamDetailsViewController?

    // MARK: - TeamDetailsDataPassing

    var dataStore: TeamDetailsDataStore?

    // MARK: - TeamDetailsRoutingLogic
}
