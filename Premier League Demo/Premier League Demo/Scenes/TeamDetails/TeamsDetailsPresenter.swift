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
        let image = UIImage.fromData(data: response.teamImageData)

        var rankItems = [StatViewModel]()
        rankItems.appendRankItem(title: "RANK", value: response.teamModel?.position)
        rankItems.appendRankItem(title: "POINTS", value: response.teamModel?.points)

        var summaryItems = [StatViewModel]()
        summaryItems.appendSummaryItem(title: "P:", value: response.teamModel?.matchesPlayed)
        summaryItems.appendSummaryItem(title: "GF:", value: response.teamModel?.seasonGoals)
        summaryItems.appendSummaryItem(title: "GA:", value: response.teamModel?.goalsAgainst)

        let viewModel = TeamDetails.Content.ViewModel(
            title: title,
            image: image,
            rankItems: rankItems,
            summaryItems: summaryItems,
            shouldShowErrorMessage: response.scene == .error,
            errorMessage: "")
        viewController?.displayContent(viewModel: viewModel)
    }
}

private extension Array where Element == StatViewModel {
    mutating func appendRankItem(title: String, value: Int?) {
        if let value = value {
            self.append(StatViewModel(title: title, value: "\(value)", titleStyle: .statTitleSmall, valueStyle: .statValueBig))
        }
    }

    mutating func appendSummaryItem(title: String, value: Int?) {
        if let value = value {
            self.append(StatViewModel(title: title, value: "\(value)", titleStyle: .statTitleSmall, valueStyle: .statValueSmall))
        }
    }
}
