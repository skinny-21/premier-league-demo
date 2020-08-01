//
//  CreditsInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol CreditsBusinessLogic {}

protocol CreditsDataStore {}

class CreditsInteractor: CreditsBusinessLogic, CreditsDataStore {

    // MARK: - Internal properties

    var presenter: CreditsPresentationLogic?

    // MARK: - Initialization

    init() {}
}
