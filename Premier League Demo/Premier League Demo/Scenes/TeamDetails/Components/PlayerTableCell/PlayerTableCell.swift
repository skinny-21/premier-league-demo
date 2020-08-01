//
//  PlayerTableCell.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

class PlayerTableCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PlayerTableCell.self)

    private let nameLabel = UILabel()
    private let positionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViewModel(_ viewModel: PlayerTableCellViewModel) {
        nameLabel.text = viewModel.name
        positionLabel.text = viewModel.position
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .background
    }

    private func setup() {
        contentView.backgroundColor = .background

        [nameLabel, positionLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        nameLabel.setTextStyle(.textLeading)
        positionLabel.setTextStyle(.text)

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            positionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            positionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
