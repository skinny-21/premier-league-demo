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
        pointsLabel.text = viewModel.points
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .background
    }

    private func setup() {
        logoImageView.backgroundColor = .primary
        contentView.backgroundColor = .background

        [positionLabel, logoImageView, nameLabel, pointsLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [positionLabel, pointsLabel].forEach {
            $0.textAlignment = .center
            $0.setTextStyle(.text)
        }

        nameLabel.setTextStyle(.textLeading)

        NSLayoutConstraint.activate([
            positionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            positionLabel.widthAnchor.constraint(equalToConstant: 24),

            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 0),
            logoImageView.widthAnchor.constraint(equalToConstant: 24),
            logoImageView.heightAnchor.constraint(equalToConstant: 24),

            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),

            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pointsLabel.widthAnchor.constraint(equalToConstant: 24),
            pointsLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
}
