//
//  LeagueTeamTableCellDelegate.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 22/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

protocol LeagueTeamTableCellDelegate: class {
    func leagueTeamTableCell(_ cell: LeagueTeamTableCell, favouritesButtonTappedFor id: Int)
}
