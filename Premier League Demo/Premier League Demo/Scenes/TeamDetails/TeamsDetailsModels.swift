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
        }

        struct ViewModel {
            let title: String?
            let image: UIImage?
            let rankItems: [StatViewModel]
            let summaryItems: [StatViewModel]
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
}
