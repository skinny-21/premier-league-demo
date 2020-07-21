//
//  TabBarRouter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TabBarRoutingLogic {

}

protocol TabBarDataPassing {
    var dataStore: TabBarDataStore? { get }
}

class TabBarRouter: TabBarRoutingLogic, TabBarDataPassing {

    // MARK: - Internal properties

    weak var viewController: TabBarViewController?

    // MARK: - TabBarDataPassing

    var dataStore: TabBarDataStore?

    // MARK: - TabBarRoutingLogic
}
