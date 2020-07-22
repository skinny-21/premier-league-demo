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
        struct Request {}

        struct Response {
            let leagueTable: [TeamModel]
        }

        struct ViewModel {
            let cellViewModels: [LeagueTeamTableCellViewModel]
            let shouldShowEmptyStateMessage: Bool
            let emptyStateMessage: String
        }
    }

    enum TeamImage {
        struct Request {
            let index: Int
        }

        struct Response {
            let index: Int
            let imageData: Data?
        }

        struct ViewModel {
            let index: Int
            let image: UIImage?
        }
    }

    struct TeamModel {
        let id: Int
        let position: Int
        let seasonGoals: Int
        let points: Int
        let seasonGoalDifference: Int
        let matchesPlayed: Int
        let name: String
        let cleanName: String
        let isFavourite: Bool
        let imageURL: URL?
    }
}
