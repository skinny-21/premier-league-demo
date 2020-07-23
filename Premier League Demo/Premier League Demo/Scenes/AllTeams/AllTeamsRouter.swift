//
//  AllTeamsRouter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol AllTeamsRoutingLogic {

}

protocol AllTeamsDataPassing {
    var dataStore: AllTeamsDataStore? { get }
}

class AllTeamsRouter: AllTeamsRoutingLogic, AllTeamsDataPassing {

    // MARK: - Internal properties

    weak var viewController: AllTeamsViewController?

    // MARK: - AllTeamsDataPassing

    var dataStore: AllTeamsDataStore?

    // MARK: - AllTeamsRoutingLogic
}
