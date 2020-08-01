//
//  PlayerDetailsPresenter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol PlayerDetailsPresentationLogic {
    func presentContent(response: PlayerDetails.Content.Response)
}

class PlayerDetailsPresenter: PlayerDetailsPresentationLogic {

    // MARK: - PlayerDetailsPresenter - Internal properties

    weak var viewController: PlayerDetailsDisplayLogic?

    // MARK: - PlayerDetailsPresentationLogic

    func presentContent(response: PlayerDetails.Content.Response) {
        var stats = [StatViewModel]()

        stats.appendFormItem(title: "AGE:", value: response.player?.age)
        stats.appendFormItem(title: "HEIGHT:", value: response.player?.height)
        stats.appendFormItem(title: "WEIGHT:", value: response.player?.weight)

        let viewModel = PlayerDetails.Content.ViewModel(name: response.player?.fullName, stats: stats)
        viewController?.displayContent(viewModel: viewModel)
    }
}
