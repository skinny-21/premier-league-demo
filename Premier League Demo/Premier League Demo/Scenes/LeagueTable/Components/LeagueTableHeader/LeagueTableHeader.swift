//
//  LeagueTableHeader.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

class LeagueTableHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = String(describing: LeagueTableHeader.self)

    private let background = UIView()
    private let positionLabel = UILabel()
    private let nameLabel = UILabel()
    private let matchesPlayedLabel = UILabel()
    private let goalsLabel = UILabel()
    private let pointsLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundView = background
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .selection

        [positionLabel, nameLabel, matchesPlayedLabel, goalsLabel, pointsLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTextStyle(.text)
        }

        [positionLabel, matchesPlayedLabel, goalsLabel, pointsLabel].forEach {
            $0.textAlignment = .center
        }

        positionLabel.text = "#"
        nameLabel.text = "Team"
        matchesPlayedLabel.text = "P"
        goalsLabel.text = "G"
        pointsLabel.text = "Pts"

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),

            positionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            positionLabel.widthAnchor.constraint(equalToConstant: 24),

            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 0),

            matchesPlayedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            matchesPlayedLabel.widthAnchor.constraint(equalToConstant: 24),
            matchesPlayedLabel.trailingAnchor.constraint(equalTo: goalsLabel.leadingAnchor),

            goalsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            goalsLabel.widthAnchor.constraint(equalToConstant: 48),
            goalsLabel.trailingAnchor.constraint(equalTo: pointsLabel.leadingAnchor),

            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pointsLabel.widthAnchor.constraint(equalToConstant: 24),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
}
