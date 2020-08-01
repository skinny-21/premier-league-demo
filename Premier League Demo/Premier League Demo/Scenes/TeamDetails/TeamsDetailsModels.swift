//
//  TeamDetailsModels.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 31/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

enum TeamDetails {
    enum Content {
        struct Request {}

        struct Response {
            let scene: Scene
            let teamModel: TeamModel?
            let teamImageData: Data?
            let isFavourite: Bool
        }

        struct ViewModel {
            let title: String?
            let image: UIImage?
            let rankItems: [StatViewModel]
            let summaryItems: [StatViewModel]
            let favouriteButtonImage: UIImage?
            let shouldShowErrorMessage: Bool
            let errorMessage: String
        }
        
        enum Scene {
            case content
            case error
        }
    }
    
    enum Details {
        struct Request {}

        struct Response {
            let players: [Player]
            let lastTenWon: Int?
            let lastTenDrawn: Int?
            let lastTenLost: Int?
        }

        struct ViewModel {
            let formItems: [StatViewModel]
            let playersCellViewModels: [PlayerTableCellViewModel]
        }
    }

    enum Favourite {
        struct Request {}

        struct Response {
            let isFavourite: Bool
        }

        struct ViewModel {
            let favouriteButtonImage: UIImage?
        }
    }
}
