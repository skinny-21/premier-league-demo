//
//  LeagueTablePresenter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

class LeagueTablePresenter: LeagueTablePresentationLogic {

    // MARK: - LeagueTablePresenter - Internal properties

    weak var viewController: LeagueTableDisplayLogic?

    // MARK: - LeagueTablePresentationLogic

    func presentContent(response: LeagueTable.Content.Response) {
        let cellViewModels = response.leagueTable.map {
            $0.leagueCellViewModel
        }

        let isLeagueTableEmpty = response.leagueTable.isEmpty

        let commonViewModel = LeagueTable.CommonViewModel(
            cellViewModels: cellViewModels,
            shouldShowError: isLeagueTableEmpty,
            errorMessage: isLeagueTableEmpty ? "Data could not be retrieved" : nil,
            shouldHideRetryButton: false)

        viewController?.displayContent(viewModel: LeagueTable.Content.ViewModel(
                                        commonViewModel: commonViewModel))
    }

    func presentTeamImage(response: LeagueTable.TeamImage.Response) {
        let image = UIImage.fromData(data: response.imageData)
        let viewModel = LeagueTable.TeamImage.ViewModel(index: response.index, image: image)
        viewController?.displayTeamImage(viewModel: viewModel)
    }

    func presentToggledFavouriteTeam(response: LeagueTable.Favourite.Response) {
        let viewModel = LeagueTable.Favourite.ViewModel(
            index: response.index,
            cellViewModel: response.teamModel.leagueCellViewModel)
        viewController?.displayToggledFavouriteTeam(viewModel: viewModel)
    }

    func presentRefreshedFavouriteTeam(response: LeagueTable.RefreshFavourite.Response) {
        let viewModel = LeagueTable.RefreshFavourite.ViewModel(
            index: response.index,
            cellViewModel: response.teamModel.leagueCellViewModel)
        viewController?.displayRefreshedFavouriteTeam(viewModel: viewModel)
    }

    func presentTeamDetails(response: LeagueTable.Details.Response) {
        viewController?.displayTeamDetails(viewModel: LeagueTable.Details.ViewModel())
    }

    func presentToggledOnlyFavourites(response: LeagueTable.ToggleFavourites.Response) {
        let cellViewModels = response.leagueTable.map {
            $0.leagueCellViewModel
        }

        let commonViewModel = LeagueTable.CommonViewModel(
            cellViewModels: cellViewModels,
            shouldShowError: response.leagueTable.isEmpty,
            errorMessage: "No favourite teams",
            shouldHideRetryButton: true)

        viewController?.displayToggledOnlyFavourites(viewModel: LeagueTable.ToggleFavourites.ViewModel(
                                                    commonViewModel: commonViewModel))
    }
}

private extension TeamModel {
    var leagueCellViewModel: LeagueTeamTableCellViewModel {
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
