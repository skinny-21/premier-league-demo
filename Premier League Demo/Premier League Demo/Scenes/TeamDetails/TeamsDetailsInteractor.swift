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
}

protocol TeamDetailsDataStore: class {
    var gateway: Gateway? { get set }
    var selectedTeamModel: TeamModel? { get set }
    var selectedTeamImageData: Data? { get set }
}

class TeamDetailsInteractor: TeamDetailsBusinessLogic, TeamDetailsDataStore {

    // MARK: - DataStore
    
    var gateway: Gateway?
    var selectedTeamModel: TeamModel?
    var selectedTeamImageData: Data?

    // MARK: - TeamDetailsDataStore

    // MARK: - Internal properties

    var presenter: TeamDetailsPresentationLogic?
    var worker: TeamDetailsWorkerProtocol?

    // MARK: - Initialization

    init(worker: TeamDetailsWorkerProtocol = TeamDetailsWorker()) {
        self.worker = worker
    }

    // MARK: - TeamDetailsBusinessLogic

    func prepareContent(request: TeamDetails.Content.Request) {
        let scene: TeamDetails.Content.Scene = selectedTeamModel != nil ? .content : .error
        let response = TeamDetails.Content.Response(scene: scene,
                                                    teamModel: selectedTeamModel,
                                                    teamImageData: selectedTeamImageData)
        presenter?.presentContent(response: response)
    }
    
    func getDetails(requset: TeamDetails.Details.Request) {
        gateway?.getTeamStats(teamId: selectedTeamModel!.id, completionHandler: { (response, error) in
            print(response?.data.first?.lastMatchesCount)
            print(response?.data.first?.name)
            print(response?.data.first?.id)
            print(response?.data.first?.stats.count)
        })
    }
}
