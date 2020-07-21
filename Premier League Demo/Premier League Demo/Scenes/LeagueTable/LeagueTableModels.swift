//
//  LeagueTableModels.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

enum LeagueTable {
    enum Content {
        struct Request {

        }

        struct Response {
            let leagueTable: [LeagueTableTeam]
        }

        struct ViewModel {
            let cellViewModels: [LeagueTeamTableCellViewModel]
            let shouldShowEmptyStateMessage: Bool
            let emptyStateMessage: String
        }
    }
}
