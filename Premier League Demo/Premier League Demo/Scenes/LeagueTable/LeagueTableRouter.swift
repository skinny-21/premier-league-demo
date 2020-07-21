//
//  LeagueTableRouter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol LeagueTableRoutingLogic {

}

protocol LeagueTableDataPassing {
    var dataStore: LeagueTableDataStore? { get }
}

class LeagueTableRouter: LeagueTableRoutingLogic, LeagueTableDataPassing {

    // MARK: - Internal properties

    weak var viewController: LeagueTableViewController?

    // MARK: - LeagueTableDataPassing

    var dataStore: LeagueTableDataStore?

    // MARK: - LeagueTableRoutingLogic
}
