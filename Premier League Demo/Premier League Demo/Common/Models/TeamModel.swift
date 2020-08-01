//
//  TeamModel.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct TeamModel {
    let id: Int
    let position: Int
    let seasonGoals: Int
    let points: Int
    let seasonGoalDifference: Int
    let matchesPlayed: Int
    let name: String
    let cleanName: String
    var isFavourite: Bool
    let imageURL: URL?
}
