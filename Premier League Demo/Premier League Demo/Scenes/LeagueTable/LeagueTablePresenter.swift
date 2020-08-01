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
    func presentToggledFavouriteTeam(response: LeagueTable.Favourite.Response)
    func presentTeamDetails(response: LeagueTable.Details.Response)
}

class LeagueTablePresenter: LeagueTablePresentationLogic {

    // MARK: - LeagueTablePresenter - Internal properties

    weak var viewController: LeagueTableDisplayLogic?

    // MARK: - LeagueTablePresentationLogic

    func presentContent(response: LeagueTable.Content.Response) {
        let cellViewModels = response.leagueTable.map {
            $0.leagueCellViewModel
        }

        let viewModel = LeagueTable.Content.ViewModel(
            cellViewModels: cellViewModels,
            shouldShowError: response.leagueTable.isEmpty)
        viewController?.displayContent(viewModel: viewModel)
    }

    func presentTeamImage(response: LeagueTable.TeamImage.Response) {
        let image = UIImage.fromData(data: response.imageData)
        let viewModel = LeagueTable.TeamImage.ViewModel(index: response.index, image: image)
        viewController?.displayTeamImage(viewModel: viewModel)
    }

    func presentToggledFavouriteTeam(response: LeagueTable.Favourite.Response) {
        let viewModel = LeagueTable.Favourite.ViewModel(index: response.index,
                                                         cellViewModel: response.teamModel.leagueCellViewModel)
        viewController?.displayToggledFavouriteTeam(viewModel: viewModel)
    }
    
    func presentTeamDetails(response: LeagueTable.Details.Response) {
        viewController?.displayTeamDetails(viewModel: LeagueTable.Details.ViewModel())
    }
}

private extension TeamModel {
    var leagueCellViewModel: LeagueTeamTableCellViewModel {
        let goalsAgainst = seasonGoals - seasonGoalDifference
        return LeagueTeamTableCellViewModel(
            id: id,
            positon: "\(position).",
            name: cleanName,
            matchesPlayed: "\(matchesPlayed)",
            goals: "\(seasonGoals):\(goalsAgainst)",
            points: "\(points)",
            isFavourite: isFavourite)
    }
}
