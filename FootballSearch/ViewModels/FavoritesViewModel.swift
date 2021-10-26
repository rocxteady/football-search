//
//  FavoritesViewModel.swift
//  FootballSearch
//
//  Created by Ulaş Sancak on 27.10.2021.
//

import Foundation
import SwiftUI
import CoreData

class FavoritesViewModel {
    
    static let shared = FavoritesViewModel()
    
    private var players: [PlayerEntity] = []

    private var teams: [TeamEntity] = []

    init() {
        let playersRequest = NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
        let teamsRequest = NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
        do {
            players = try PersistenceController.shared.container.viewContext.fetch(playersRequest)
            teams = try PersistenceController.shared.container.viewContext.fetch(teamsRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(player: Player) throws {
        let entity = PlayerEntity(player: player)
        do {
            try PersistenceController.shared.container.viewContext.save()
            players.append(entity)
        } catch {
            throw error
        }
    }
    
    func add(team: Team) throws {
        let entity = TeamEntity(team: team)
        do {
            try PersistenceController.shared.container.viewContext.save()
            teams.append(entity)
        } catch {
            throw error
        }
    }
    
    func isFavorited(player: Player) -> Bool {
        return players.contains(where: { $0.playerID == player.playerID })
    }
    
    func isFavorited(team: Team) -> Bool {
        return teams.contains(where: { $0.teamID == team.teamID })
    }
    
    func removePlayer(player: Player) throws {
        guard let index = players.firstIndex(where: {$0.playerID == player.playerID }) else { return }
        try removePlayer(at: index)
    }
    
    func removePlayer(at index: Int) throws {
        PersistenceController.shared.container.viewContext.delete(players[index])
        do {
            try PersistenceController.shared.container.viewContext.save()
            players.remove(at: index)
        } catch {
            throw error
        }
    }
    
    func removeTeam(team: Team) throws {
        guard let index = teams.firstIndex(where: {$0.teamID == team.teamID }) else { return }
        try removeTeam(at: index)
    }
    
    func removeTeam(at index: Int) throws {
        PersistenceController.shared.container.viewContext.delete(teams[index])
        do {
            try PersistenceController.shared.container.viewContext.save()
            teams.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
