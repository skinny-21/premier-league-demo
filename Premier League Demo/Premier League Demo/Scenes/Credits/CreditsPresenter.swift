//
//  CreditsPresenter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol CreditsPresentationLogic {}

class CreditsPresenter: CreditsPresentationLogic {

    // MARK: - CreditsPresenter - Internal properties

    weak var viewController: CreditsDisplayLogic?
}
