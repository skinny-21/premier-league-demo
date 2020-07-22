//
//  LeagueTablePresenter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol LeagueTablePresentationLogic {
    func presentContent(response: LeagueTable.Content.Response)
    func presentTeamImage(response: LeagueTable.TeamImage.Response)
}

class LeagueTablePresenter: LeagueTablePresentationLogic {

    // MARK: - LeagueTablePresenter - Internal properties

    weak var viewController: LeagueTableDisplayLogic?

    // MARK: - LeagueTablePresentationLogic

    func presentContent(response: LeagueTable.Content.Response) {
        let cellViewModels: [LeagueTeamTableCellViewModel] = response.leagueTable.map {
            let goalsAgainst = $0.seasonGoals - $0.seasonGoalDifference
            return LeagueTeamTableCellViewModel(positon: "\($0.position).",
                                         name: $0.cleanName,
                                         matchesPlayed: "\($0.matchesPlayed)",
                                         goals: "\($0.seasonGoals):\(goalsAgainst)",
                                         points: "\($0.points)")
        }

        let viewModel = LeagueTable.Content.ViewModel(cellViewModels: cellViewModels,
                                                      shouldShowEmptyStateMessage: response.leagueTable.isEmpty,
                                                      emptyStateMessage: "Error")
        viewController?.displayContent(viewModel: viewModel)
    }

    func presentTeamImage(response: LeagueTable.TeamImage.Response) {
        var image: UIImage?

        if let imageData = response.imageData {
            image = UIImage(data: imageData)
        }

        let viewModel = LeagueTable.TeamImage.ViewModel(index: response.index, image: image)
        viewController?.displayTeamImage(viewModel: viewModel)
    }
}
