//
//  LeagueTableInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol LeagueTableBusinessLogic {
    func prepareContent(request: LeagueTable.Content.Request)
    func getTeamImage(request: LeagueTable.TeamImage.Request)
    func toggleFavouriteTeam(request: LeagueTable.Favourite.Request)
    func teamDetails(request: LeagueTable.Details.Request)
}

protocol LeagueTableDataStore: class {
    var gateway: Gateway? { get set }
    var selectedTeamModel: TeamModel? { get }
    var selectedTeamImageData: Data? { get }
}

class LeagueTableInteractor: LeagueTableBusinessLogic, LeagueTableDataStore {

    // MARK: - LeagueTableDataStore

    var gateway: Gateway?
    var selectedTeamModel: TeamModel?
    var selectedTeamImageData: Data?

    // MARK: - Internal properties

    var presenter: LeagueTablePresentationLogic?
    var worker: LeagueTableWorkerProtocol?

    // MARK: - Private properties

    private var leagueTable = [TeamModel]()
    private var teamsImagesData = [Int: Data]()

    // MARK: - Initialization

    init(worker: LeagueTableWorkerProtocol = LeagueTableWorker()) {
        self.worker = worker
    }

    // MARK: - LeagueTableBusinessLogic

    func prepareContent(request: LeagueTable.Content.Request) {
        worker?.gateway = gateway
        worker?.getLeagueTable(completion: { [weak self] (leagueTable) in
            guard let self = self else { return }
            self.leagueTable = leagueTable.sorted { $0.position < $1.position }
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

        guard let teamIndex = leagueTable.firstIndex(where: { $0.id == request.teamId }) else {
            return
        }

        leagueTable[teamIndex].isFavourite = isFavourite
        let response = LeagueTable.Favourite.Response(index: teamIndex, teamModel: leagueTable[teamIndex])
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
}
