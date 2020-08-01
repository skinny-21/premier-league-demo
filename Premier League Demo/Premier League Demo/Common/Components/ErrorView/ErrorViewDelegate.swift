//
//  ErrorViewDelegate.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

protocol ErrorViewDelegate: class {
    func errorViewRequestedRetryAction(_ errorView: ErrorView)
}
