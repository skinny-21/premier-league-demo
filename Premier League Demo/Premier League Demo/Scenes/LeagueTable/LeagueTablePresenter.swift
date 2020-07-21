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
}

class LeagueTablePresenter: LeagueTablePresentationLogic {

    // MARK: - LeagueTablePresenter - Internal properties

    weak var viewController: LeagueTableDisplayLogic?

    // MARK: - LeagueTablePresentationLogic

    func presentContent(response: LeagueTable.Content.Response) {
        let cellViewModels = response.leagueTable.map {
            LeagueTeamTableCellViewModel(positon: "\($0.position).", name: $0.cleanName, points: "\($0.points)")
        }

        let viewModel = LeagueTable.Content.ViewModel(cellViewModels: cellViewModels,
                                                      shouldShowEmptyStateMessage: response.leagueTable.isEmpty,
                                                      emptyStateMessage: "Error")
        viewController?.displayContent(viewModel: viewModel)
    }
}
