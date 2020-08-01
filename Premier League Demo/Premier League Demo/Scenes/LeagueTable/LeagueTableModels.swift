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
            let shouldShowError: Bool
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

    enum Favourite {
        struct Request {
            let teamId: Int
            let isFavourite: Bool
        }

        struct Response {
            let index: Int
            let teamModel: TeamModel
        }

        struct ViewModel {
            let index: Int
            let cellViewModel: LeagueTeamTableCellViewModel
        }
    }
    
    enum Details {
        struct Request {
            let index: Int
        }

        struct Response {}
        struct ViewModel {}
    }

    enum RefreshFavourite {
        struct Request {}

        struct Response {
            let index: Int
            let teamModel: TeamModel
        }

        struct ViewModel {
            let index: Int
            let cellViewModel: LeagueTeamTableCellViewModel
        }
    }
}
