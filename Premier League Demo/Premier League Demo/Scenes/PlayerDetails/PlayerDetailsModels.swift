//
//  PlayerDetailsModels.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

enum PlayerDetails {
    enum Content {
        struct Request {}

        struct Response {
            let player: Player?
        }

        struct ViewModel {
            let name: String?
            let stats: [StatViewModel]
        }
    }
}
