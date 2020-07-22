//
//  LeagueTeamTableCell.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

class LeagueTeamTableCell: UITableViewCell {
    static let reuseIdentifier = String(describing: LeagueTeamTableCell.self)

    private let positionLabel = UILabel()
    private let logoImageView = UIImageView()
    private let nameLabel = UILabel()
    private let matchesPlayedLabel = UILabel()
    private let goalsLabel = UILabel()
    private let pointsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViewModel(_ viewModel: LeagueTeamTableCellViewModel) {
        positionLabel.text = viewModel.positon
        nameLabel.text = viewModel.name
        matchesPlayedLabel.text = viewModel.matchesPlayed
        goalsLabel.text = viewModel.goals
        pointsLabel.text = viewModel.points
    }

    func setImage(_ image: UIImage?) {
        logoImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setDefaultAppearance()
    }

    private func setDefaultAppearance() {
        contentView.backgroundColor = .background
        logoImageView.image = .placeholder
    }

    private func setup() {
        setDefaultAppearance()

        [positionLabel, logoImageView, nameLabel, matchesPlayedLabel, goalsLabel, pointsLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [positionLabel, matchesPlayedLabel, goalsLabel, pointsLabel].forEach {
            $0.textAlignment = .center
            $0.setTextStyle(.text)
        }

        nameLabel.setTextStyle(.textLeading)

        NSLayoutConstraint.activate([
            positionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            positionLabel.widthAnchor.constraint(equalToConstant: 24),

            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 24),
            logoImageView.heightAnchor.constraint(equalToConstant: 24),

            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),

            matchesPlayedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            matchesPlayedLabel.widthAnchor.constraint(equalToConstant: 24),
            matchesPlayedLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),

            goalsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            goalsLabel.widthAnchor.constraint(equalToConstant: 48),
            goalsLabel.leadingAnchor.constraint(equalTo: matchesPlayedLabel.trailingAnchor),

            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pointsLabel.widthAnchor.constraint(equalToConstant: 24),
            pointsLabel.leadingAnchor.constraint(equalTo: goalsLabel.trailingAnchor),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
}

private extension UIImage {
    static let placeholder = UIImage(named: "team_logo_placeholder")
}
