//
//  CreditsRouter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol CreditsRoutingLogic {}

protocol CreditsDataPassing {
    var dataStore: CreditsDataStore? { get }
}

class CreditsRouter: CreditsRoutingLogic, CreditsDataPassing {

    // MARK: - Internal properties

    weak var viewController: CreditsViewController?

    // MARK: - CreditsDataPassing

    var dataStore: CreditsDataStore?
}
