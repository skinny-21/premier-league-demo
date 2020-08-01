//
//  TeamDetailsInteractor.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 31/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TeamDetailsBusinessLogic {
    func prepareContent(request: TeamDetails.Content.Request)
    func getDetails(requset: TeamDetails.Details.Request)
    func toggleFavouriteTeam(request: TeamDetails.Favourite.Request)

}

protocol TeamDetailsDataStore: class {
    var gateway: Gateway? { get set }
    var selectedTeamModel: TeamModel? { get set }
    var selectedTeamImageData: Data? { get set }
}

class TeamDetailsInteractor: TeamDetailsBusinessLogic, TeamDetailsDataStore {

    // MARK: - TeamDetailsDataStore

    var gateway: Gateway?
    var selectedTeamModel: TeamModel?
    var selectedTeamImageData: Data?

    // MARK: - Internal properties

    var presenter: TeamDetailsPresentationLogic?
    var worker: TeamDetailsWorkerProtocol?

    // MARK: - Private properties

    private var players = [Player]()

    // MARK: - Initialization

    init(worker: TeamDetailsWorkerProtocol = TeamDetailsWorker()) {
        self.worker = worker
    }

    // MARK: - TeamDetailsBusinessLogic

    func prepareContent(request: TeamDetails.Content.Request) {
        worker?.gateway = gateway

        var isFavourite = false
        if let teamId = selectedTeamModel?.id {
            isFavourite = worker?.isTeamFavourite(teamId: teamId) ?? false
        }

        let scene: TeamDetails.Content.Scene = selectedTeamModel != nil ? .content : .error
        let response = TeamDetails.Content.Response(scene: scene,
                                                    teamModel: selectedTeamModel,
                                                    teamImageData: selectedTeamImageData,
                                                    isFavourite: isFavourite)
        presenter?.presentContent(response: response)
    }
    
    func getDetails(requset: TeamDetails.Details.Request) {
        guard let teamId = selectedTeamModel?.id else {
            return
        }
        
        worker?.getTeamDetails(teamId: teamId, completion: { [weak self] (players, stats) in
            guard let self = self else { return }

            self.players = players.sorted(by: {
                $0.position < $1.position
            })
            let response = TeamDetails.Details.Response(players: self.players,
                                                        lastTenWon: stats.intValue(for: .lastTenWon),
                                                        lastTenDrawn: stats.intValue(for: .lastTenDrawn),
                                                        lastTenLost: stats.intValue(for: .lastTenLost))
            self.presenter?.presentDetails(response: response)
        })
    }

    func toggleFavouriteTeam(request: TeamDetails.Favourite.Request) {
        guard let teamId = selectedTeamModel?.id, let worker = worker else {
            return
        }

        let isFavaouriteUpdated = worker.toggleFavouriteTeam(teamId: teamId)
        let response = TeamDetails.Favourite.Response(isFavourite: isFavaouriteUpdated)
        presenter?.presentToggledFavouriteTeam(response: response)
    }
}

private enum StatKey: String {
    case lastTenWon = "seasonWinsNum_overall"
    case lastTenDrawn = "seasonDrawsNum_overall"
    case lastTenLost = "seasonLossesNum_overall"
}

private extension Dictionary where Key == String, Value == Stat {
    func intValue(for key: StatKey) -> Int? {
        guard let stringValue = self[key.rawValue]?.value else {
            return nil
        }

        return Double(stringValue)?.intValue
    }
}

private extension Double {
    var intValue: Int? {
        Int(self)
    }
}
