//
//  TeamDetailsPresenter.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 31/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TeamDetailsPresentationLogic {
    func presentContent(response: TeamDetails.Content.Response)
}

class TeamDetailsPresenter: TeamDetailsPresentationLogic {

    // MARK: - TeamDetailsPresenter - Internal properties

    weak var viewController: TeamDetailsDisplayLogic?

    // MARK: - TeamDetailsPresentationLogic

    func presentContent(response: TeamDetails.Content.Response) {
        let title = response.teamModel?.cleanName
//        let image = UIImage.fromData(data: response.teamImageData)
        
        let viewModel = TeamDetails.Content.ViewModel(
            title: title,
            shouldShowErrorMessage: response.scene == .error,
            errorMessage: "")
        viewController?.displayContent(viewModel: viewModel)
    }
}
