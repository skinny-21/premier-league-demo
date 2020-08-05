//
//  LeagueTableDisplayLogicMock.swift
//  Premier League DemoTests
//
//  Created by Wojciech Woźniak on 05/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

class LeagueTableDisplayLogicMock: LeagueTableDisplayLogic {
    private(set) var displayContentCallsCount = 0
    private(set) var displayContentViewModel: LeagueTable.Content.ViewModel?
    func displayContent(viewModel: LeagueTable.Content.ViewModel) {
        displayContentCallsCount += 1
        displayContentViewModel = viewModel
    }

    private(set) var displayTeamImageCallsCount = 0
    private(set) var displayTeamImageViewModel: LeagueTable.TeamImage.ViewModel?
    func displayTeamImage(viewModel: LeagueTable.TeamImage.ViewModel) {
        displayTeamImageCallsCount += 1
        displayTeamImageViewModel = viewModel
    }

    private(set) var displayToggledFavouriteTeamCallsCount = 0
    private(set) var displayToggledFavouriteTeamViewModel: LeagueTable.Favourite.ViewModel?
    func displayToggledFavouriteTeam(viewModel: LeagueTable.Favourite.ViewModel) {
        displayToggledFavouriteTeamCallsCount += 1
        displayToggledFavouriteTeamViewModel = viewModel
    }

    private(set) var displayTeamDetailsCallsCount = 0
    private(set) var displayTeamDetailsViewModel: LeagueTable.Details.ViewModel?
    func displayTeamDetails(viewModel: LeagueTable.Details.ViewModel) {
        displayTeamDetailsCallsCount += 1
        displayTeamDetailsViewModel = viewModel
    }

    private(set) var displayRefreshedFavouriteTeamCallsCount = 0
    private(set) var displayRefreshedFavouriteTeamViewModel: LeagueTable.RefreshFavourite.ViewModel?
    func displayRefreshedFavouriteTeam(viewModel: LeagueTable.RefreshFavourite.ViewModel) {
        displayRefreshedFavouriteTeamCallsCount += 1
        displayRefreshedFavouriteTeamViewModel = viewModel
    }

    private(set) var displayToggledOnlyFavouritesCallsCount = 0
    private(set) var displayToggledOnlyFavouritesViewModel: LeagueTable.ToggleFavourites.ViewModel?
    func displayToggledOnlyFavourites(viewModel: LeagueTable.ToggleFavourites.ViewModel) {
        displayToggledOnlyFavouritesCallsCount += 1
        displayToggledOnlyFavouritesViewModel = viewModel
    }
}
