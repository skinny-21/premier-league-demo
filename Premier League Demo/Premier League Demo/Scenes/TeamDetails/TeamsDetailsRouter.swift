//
//  TeamDetailsRouter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 31/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TeamDetailsRoutingLogic {
    func routeBack()
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

    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
        if let leagueTableViewController = viewController?.navigationController?.topViewController as? LeagueTableViewController {
            leagueTableViewController.router?.dataStore?.selectedTeamModel = dataStore?.selectedTeamModel
        }
    }
}
