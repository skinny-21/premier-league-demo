//
//  LeagueTableContracts.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 05/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

protocol LeagueTableBusinessLogic {
    func prepareContent(request: LeagueTable.Content.Request)
    func getTeamImage(request: LeagueTable.TeamImage.Request)
    func toggleFavouriteTeam(request: LeagueTable.Favourite.Request)
    func teamDetails(request: LeagueTable.Details.Request)
    func refreshFavourite(request: LeagueTable.RefreshFavourite.Request)
    func toggleOnlyFavourites(request: LeagueTable.ToggleFavourites.Request)
}

protocol LeagueTableDataStore: class {
    var gateway: Gateway? { get set }
    var selectedTeamModel: TeamModel? { get set }
    var selectedTeamImageData: Data? { get }
}

protocol LeagueTablePresentationLogic {
    func presentContent(response: LeagueTable.Content.Response)
    func presentTeamImage(response: LeagueTable.TeamImage.Response)
    func presentToggledFavouriteTeam(response: LeagueTable.Favourite.Response)
    func presentRefreshedFavouriteTeam(response: LeagueTable.RefreshFavourite.Response)
    func presentTeamDetails(response: LeagueTable.Details.Response)
    func presentToggledOnlyFavourites(response: LeagueTable.ToggleFavourites.Response)
}

protocol LeagueTableDisplayLogic: class {
    func displayContent(viewModel: LeagueTable.Content.ViewModel)
    func displayTeamImage(viewModel: LeagueTable.TeamImage.ViewModel)
    func displayToggledFavouriteTeam(viewModel: LeagueTable.Favourite.ViewModel)
    func displayTeamDetails(viewModel: LeagueTable.Details.ViewModel)
    func displayRefreshedFavouriteTeam(viewModel: LeagueTable.RefreshFavourite.ViewModel)
    func displayToggledOnlyFavourites(viewModel: LeagueTable.ToggleFavourites.ViewModel)
}

protocol LeagueTableWorkerProtocol {
    var gateway: Gateway? { get set }
    func getLeagueTable(completion: @escaping ([TeamModel]) -> Void)
    func getImage(url: URL, completion: @escaping (Data?) -> Void)
    func toggleFavouriteTeam(id: Int, isFavourite: Bool) -> Bool
}

protocol LeagueTableRoutingLogic: class {
    func routeToTeamDetails()
}

protocol LeagueTableDataPassing: class {
    var dataStore: LeagueTableDataStore? { get }
}
