//
//  LeagueTableInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

class LeagueTableInteractor: LeagueTableBusinessLogic, LeagueTableDataStore {

    // MARK: - LeagueTableDataStore

    var gateway: Gateway?
    var selectedTeamModel: TeamModel?
    var selectedTeamImageData: Data?

    // MARK: - Internal properties

    var presenter: LeagueTablePresentationLogic?
    var worker: LeagueTableWorkerProtocol?

    // MARK: - Private properties

    private var originalLeagueTable = [TeamModel]()
    private var leagueTable = [TeamModel]()
    private var teamsImagesData = [Int: Data]()
    private var shouldDisplayOnlyFavourites = false

    // MARK: - Initialization

    init(worker: LeagueTableWorkerProtocol = LeagueTableWorker()) {
        self.worker = worker
    }

    // MARK: - LeagueTableBusinessLogic

    func prepareContent(request: LeagueTable.Content.Request) {
        worker?.gateway = gateway
        worker?.getLeagueTable(completion: { [weak self] (leagueTable) in
            guard let self = self else { return }
            self.originalLeagueTable = leagueTable.sorted { $0.position < $1.position }
            self.leagueTable = self.originalLeagueTable
            let response = LeagueTable.Content.Response(leagueTable: self.leagueTable)
            self.presenter?.presentContent(response: response)
        })
    }

    func getTeamImage(request: LeagueTable.TeamImage.Request) {
        guard leagueTable.indices.contains(request.index), let imageURL = leagueTable[request.index].imageURL else {
            return
        }

        worker?.getImage(url: imageURL, completion: { [weak self] data in
            guard let self = self else { return }
            let teamId = self.leagueTable[request.index].id
            self.teamsImagesData[teamId] = data
            let response = LeagueTable.TeamImage.Response(index: request.index, imageData: data)
            self.presenter?.presentTeamImage(response: response)
        })
    }

    func toggleFavouriteTeam(request: LeagueTable.Favourite.Request) {
        guard let isFavourite = worker?.toggleFavouriteTeam(id: request.teamId, isFavourite: request.isFavourite) else {
            return
        }

        guard let originalLeagueTableIndex = originalLeagueTable.firstIndex(where: { $0.id == request.teamId }) else {
            return
        }

        originalLeagueTable[originalLeagueTableIndex].isFavourite = isFavourite

        guard let leagueTableIndex = leagueTable.firstIndex(where: { $0.id == request.teamId }) else {
            return
        }

        leagueTable[leagueTableIndex].isFavourite = isFavourite
        let response = LeagueTable.Favourite.Response(index: leagueTableIndex, teamModel: leagueTable[leagueTableIndex])
        presenter?.presentToggledFavouriteTeam(response: response)
    }
    
    func teamDetails(request: LeagueTable.Details.Request) {
        guard leagueTable.indices.contains(request.index) else {
            return
        }
        
        let teamModel = leagueTable[request.index]
        selectedTeamModel = teamModel
        selectedTeamImageData = teamsImagesData[teamModel.id]
        presenter?.presentTeamDetails(response: LeagueTable.Details.Response())
    }

    func refreshFavourite(request: LeagueTable.RefreshFavourite.Request) {
        guard let selectedTeamModel = selectedTeamModel else {
            return
        }

        guard let originalLeagueTableIndex = originalLeagueTable.firstIndex(where: { $0.id == selectedTeamModel.id }) else {
            return
        }

        originalLeagueTable[originalLeagueTableIndex].isFavourite = selectedTeamModel.isFavourite

        guard let leagueTableIndex = leagueTable.firstIndex(where: { $0.id == selectedTeamModel.id }) else {
            return
        }

        leagueTable[leagueTableIndex] = selectedTeamModel
        let response = LeagueTable.RefreshFavourite.Response(index: leagueTableIndex, teamModel: leagueTable[leagueTableIndex])
        presenter?.presentRefreshedFavouriteTeam(response: response)
    }

    func toggleOnlyFavourites(request: LeagueTable.ToggleFavourites.Request) {
        shouldDisplayOnlyFavourites.toggle()

        if shouldDisplayOnlyFavourites {
            leagueTable = originalLeagueTable.filter({ $0.isFavourite })
        } else {
            leagueTable = originalLeagueTable
        }

        let response = LeagueTable.ToggleFavourites.Response(leagueTable: leagueTable)
        self.presenter?.presentToggledOnlyFavourites(response: response)
    }
}
