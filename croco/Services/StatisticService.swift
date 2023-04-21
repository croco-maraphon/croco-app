//
//  StatisticService.swift
//  croco
//
//  Created by Ramil Yanberdin on 18.04.2023.
//

import Foundation

struct Team: Codable, Equatable, Identifiable {
    var id = UUID().uuidString
    var teamName: String
    var teamImage: String
    var teamScore: Int
}

final class StatisticService {
    enum Keys: String {
        case leaderboard, lastGameTeams
    }

    private let userDefaults = UserDefaults.standard

    private var teams: [Team]

    init() {
        if let data = userDefaults.object(forKey: Keys.leaderboard.rawValue) as? Data,
           let teams = try? JSONDecoder().decode([Team].self,from: data) {
            self.teams = teams
        } else {
            teams = []
        }
    }

    public func createTeam(_ team: Team) {
        if self.teams.first(where: { $0 == team }) == nil {
            self.teams.append(team)
            setData(teams: self.teams, key: Keys.leaderboard)
        }
    }

    public func getLeaderboard() -> [Team] {
        self.teams
    }

    public func getLastGameTeams() -> [Team] {
        if let data = userDefaults.object(forKey: Keys.lastGameTeams.rawValue) as? Data,
           let teams = try? JSONDecoder().decode([Team].self, from: data) {
            return teams
        } else {
            return []
        }
    }

    public func updateLeaderboard(gameResult: [Team]) {
        for index in 0..<self.teams.count {
            if let team = gameResult.first(where: { $0.id == self.teams[index].id }) {
                self.teams[index].teamScore += team.teamScore
            }
        }
        setData(teams: self.teams, key: Keys.leaderboard)
        setData(teams: gameResult, key: Keys.lastGameTeams)
    }

    public func updateTeamName(team: Team, newName: String) {
        if let index = self.teams.firstIndex(where: { $0.id == team.id }) {
            self.teams[index].teamName = newName

            setData(teams: self.teams, key: Keys.leaderboard)
        } else {
            fatalError("Team to rename not found")
        }
    }

    public func deleteTeams() {
        userDefaults.removeObject(forKey: Keys.leaderboard.rawValue)
    }

    private func setData(teams: [Team], key: Keys) {
        if let encode = try? JSONEncoder().encode(teams) {
            userDefaults.set(encode, forKey: key.rawValue)
        }
    }
}
