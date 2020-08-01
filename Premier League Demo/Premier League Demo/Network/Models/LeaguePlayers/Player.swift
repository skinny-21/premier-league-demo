//
//  Player.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct Player: Decodable {
    let concededAway: Int
    let penaltyMisses, id: Int
    let goalsPer90_Away: Double
    let concededHome, penaltySuccess, weight, clubTeam2_ID: Int
    let goalsOverall, assistsHome, redCardsOverall, lastMatchTimestamp: Int
    let position: PlayerPosition
    let goalsInvolvedPer90_Overall: Double
    let nationality: String
    let url: String
    let minPerConcededOverall: Int
    let knownAs: String
    let goalsAway, appearancesOverall, minutesPlayedAway, cleanSheetsAway: Int
    let nationalTeamID, yellowCardsOverall: Int
    let minPerMatch, rankInClubTopScorer, cleanSheetsPerOverall: Int
    let goalsPer90_Overall, goalsPer90_Home: Double
    let startingYear: Int
    let cardsPer90_Overall: Double
    let shorthand: String
    let rankInLeagueTopMidfielders, height, assistsAway, concededOverall: Int
    let assistsOverall, penaltyGoals: Int
    let lastName: String
    let appearancesAway, minutesPlayedOverall, clubTeamID, competitionID: Int
    let age, minPerAssistOverall, minPerGoalOverall, birthday: Int
    let rankInLeagueTopAttackers, endingYear, rankInLeagueTopDefenders, cardsOverall: Int
    let goalsHome, cleanSheetsHome: Int
    let firstName: String
    let minPerCardOverall, appearancesHome: Int
    let assistsPer90_Overall: Double
    let minutesPlayedHome, concededPer90_Overall: Int
    let fullName: String
    let cleanSheetsOverall: Int

    enum CodingKeys: String, CodingKey {
        case concededAway = "conceded_away"
        case penaltyMisses = "penalty_misses"
        case id
        case goalsPer90_Away = "goals_per_90_away"
        case concededHome = "conceded_home"
        case penaltySuccess = "penalty_success"
        case weight
        case clubTeam2_ID = "club_team_2_id"
        case goalsOverall = "goals_overall"
        case assistsHome = "assists_home"
        case redCardsOverall = "red_cards_overall"
        case lastMatchTimestamp = "last_match_timestamp"
        case position
        case goalsInvolvedPer90_Overall = "goals_involved_per_90_overall"
        case nationality, url
        case minPerConcededOverall = "min_per_conceded_overall"
        case knownAs = "known_as"
        case goalsAway = "goals_away"
        case appearancesOverall = "appearances_overall"
        case minutesPlayedAway = "minutes_played_away"
        case cleanSheetsAway = "clean_sheets_away"
        case nationalTeamID = "national_team_id"
        case yellowCardsOverall = "yellow_cards_overall"
        case minPerMatch = "min_per_match"
        case rankInClubTopScorer = "rank_in_club_top_scorer"
        case cleanSheetsPerOverall = "clean_sheets_per_overall"
        case goalsPer90_Overall = "goals_per_90_overall"
        case goalsPer90_Home = "goals_per_90_home"
        case startingYear = "starting_year"
        case cardsPer90_Overall = "cards_per_90_overall"
        case shorthand
        case rankInLeagueTopMidfielders = "rank_in_league_top_midfielders"
        case height
        case assistsAway = "assists_away"
        case concededOverall = "conceded_overall"
        case assistsOverall = "assists_overall"
        case penaltyGoals = "penalty_goals"
        case lastName = "last_name"
        case appearancesAway = "appearances_away"
        case minutesPlayedOverall = "minutes_played_overall"
        case clubTeamID = "club_team_id"
        case competitionID = "competition_id"
        case age
        case minPerAssistOverall = "min_per_assist_overall"
        case minPerGoalOverall = "min_per_goal_overall"
        case birthday
        case rankInLeagueTopAttackers = "rank_in_league_top_attackers"
        case endingYear = "ending_year"
        case rankInLeagueTopDefenders = "rank_in_league_top_defenders"
        case cardsOverall = "cards_overall"
        case goalsHome = "goals_home"
        case cleanSheetsHome = "clean_sheets_home"
        case firstName = "first_name"
        case minPerCardOverall = "min_per_card_overall"
        case appearancesHome = "appearances_home"
        case assistsPer90_Overall = "assists_per_90_overall"
        case minutesPlayedHome = "minutes_played_home"
        case concededPer90_Overall = "conceded_per_90_overall"
        case fullName = "full_name"
        case cleanSheetsOverall = "clean_sheets_overall"
    }
}
