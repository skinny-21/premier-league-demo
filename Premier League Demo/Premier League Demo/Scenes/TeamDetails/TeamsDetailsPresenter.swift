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
    func presentDetails(response: TeamDetails.Details.Response)
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

    func presentDetails(response: TeamDetails.Details.Response) {
        var formItems = [StatViewModel]()
        formItems.appendFormItem(title: "WON", value: response.lastTenWon)
        formItems.appendFormItem(title: "DRAWN", value: response.lastTenDrawn)
        formItems.appendFormItem(title: "LOST", value: response.lastTenLost)

        let viewModel = TeamDetails.Details.ViewModel(formItems: formItems)
        viewController?.displayDetails(viewModel: viewModel)
    }

}

private extension Array where Element == StatViewModel {
    mutating func appendRankItem(title: String, value: Int?) {
        appendStatItem(title: title, value: value, titleStyle: .statTitleSmall, valueStyle: .statValueBig)
    }

    mutating func appendSummaryItem(title: String, value: Int?) {
        appendStatItem(title: title, value: value, titleStyle: .statTitleSmall, valueStyle: .statValueSmall)
    }

    mutating func appendFormItem(title: String, value: Int?) {
        appendStatItem(title: title, value: value, titleStyle: .statTitleBig, valueStyle: .statValueBig)
    }

    private mutating func appendStatItem(title: String, value: Int?, titleStyle: TextStyle, valueStyle: TextStyle) {
        if let value = value {
            self.append(StatViewModel(title: title, value: "\(value)", titleStyle: titleStyle, valueStyle: valueStyle))
        }
    }
}
