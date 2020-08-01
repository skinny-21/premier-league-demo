//
//  TeamDetailsWorker.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 31/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

protocol TeamDetailsWorkerProtocol {
    var gateway: Gateway? { get set }
    func getTeamDetails(teamId: Int, completion: @escaping (_ players: [Player], _ stats: [String: Stat]) -> Void)
    func isTeamFavourite(teamId: Int) -> Bool
    func toggleFavouriteTeam(teamId: Int) -> Bool
}

class TeamDetailsWorker: TeamDetailsWorkerProtocol {
    var gateway: Gateway?

    private let localStorage: LocalStorage

    init(localStorage: LocalStorage = UserDefaultsStorage()) {
        self.localStorage = localStorage
    }

    func getTeamDetails(teamId: Int, completion: @escaping (_ players: [Player], _ stats: [String: Stat]) -> Void) {
        var players = [Player]()
        var stats = [String: Stat]()
        
        let downloadQueue = DispatchQueue(label: "detailsDownloadQueue", attributes: .concurrent)
        let group = DispatchGroup()
        
        group.enter()
        downloadQueue.async {
            self.getTeamPlayers(teamId: teamId) { (teamPlayers) in
                players = teamPlayers
                group.leave()
            }
        }
        
        group.enter()
        downloadQueue.async {
            self.getTeamStats(teamId: teamId) { (teamStats) in
                stats = teamStats
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            completion(players, stats)
        }
    }

    func isTeamFavourite(teamId: Int) -> Bool {
        return localStorage.isFavourite(id: teamId)
    }

    func toggleFavouriteTeam(teamId: Int) -> Bool {
        let isFavouriteUpdated = !isTeamFavourite(teamId: teamId)
        localStorage.saveToFavourites(id: teamId, isFavourite: isFavouriteUpdated)
        return isFavouriteUpdated
    }

    private func getTeamStats(teamId: Int, completion: @escaping ([String: Stat]) -> Void) {
        guard let gateway = gateway else {
            completion([:])
            return
        }
        
        gateway.getTeamStats(teamId: teamId, completionHandler: { (response, error) in
            var stats = [String: Stat]()
            
            defer {
                completion(stats)
            }
            
            guard let response = response else {
                return
            }
            
            guard let lastTenStats = response.data.first(where: { $0.lastMatchesCount == 10 }) else {
                return
            }
            
            stats = lastTenStats.stats
        })
    }
    
    private func getTeamPlayers(teamId: Int, completion: @escaping ([Player]) -> Void) {
        guard let gateway = gateway else {
            completion([])
            return
        }
                
        gateway.getLeaguePlayers(page: 1) { [weak self] (response, _) in
            guard let response = response else {
                completion([])
                return
            }
            
            var players = response.data
            
            guard response.pager.maxPage > 1 else {
                completion(players.of(teamId: teamId))
                return
            }
            
            self?.getPlayersOtherPages(maxPage: response.pager.maxPage) { (otherPlayersPages) in
                players.append(contentsOf: otherPlayersPages)
                completion(players.of(teamId: teamId))
            }
        }
    }
    
    private func getPlayersOtherPages(maxPage: Int, completion: @escaping ([Player]) -> Void) {
        guard let gateway = gateway else {
            completion([])
            return
        }
        
        var players = [Player]()
        let downloadQueue = DispatchQueue(label: "playersDownloadQueue", attributes: .concurrent)
        let writeQueue = DispatchQueue(label: "playersWriteQueue")
        let group = DispatchGroup()
        
        for i in 2...maxPage {
            group.enter()
            
            downloadQueue.async {
                gateway.getLeaguePlayers(page: i) { (response, _) in
                    writeQueue.async {
                        players.append(contentsOf: response?.data ?? [])
                        group.leave()
                    }
                }
            }
        }
        
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            completion(players)
        }
    }
}

private extension Array where Element == Player {
    func of(teamId: Int) -> [Player] {
        filter { $0.clubTeamID == teamId }
    }
}
