//
//  LeagueTableRouter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol LeagueTableRoutingLogic: class {
    func routeToTeamDetails()
}

protocol LeagueTableDataPassing: class {
    var dataStore: LeagueTableDataStore? { get }
}

class LeagueTableRouter: LeagueTableRoutingLogic, LeagueTableDataPassing {

    // MARK: - Internal properties

    weak var viewController: LeagueTableViewController?

    // MARK: - LeagueTableDataPassing

    var dataStore: LeagueTableDataStore?

    // MARK: - LeagueTableRoutingLogic
    
    func routeToTeamDetails() {
        let detailsViewController = TeamDetailsViewController()
        
        if let detailsDataStore = detailsViewController.router?.dataStore {
            detailsDataStore.gateway = dataStore?.gateway
            detailsDataStore.selectedTeamModel = dataStore?.selectedTeamModel
            detailsDataStore.selectedTeamImageData = dataStore?.selectedTeamImageData
        }
        
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
