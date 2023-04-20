//
//  StatisticService.swift
//  croco
//
//  Created by Ramil Yanberdin on 18.04.2023.
//

import Foundation

struct Team: Codable, Equatable {
    var id = UUID().uuidString
    var teamName: String
    var teamImage: String
    var teamScore: Int
}

final class StatisticService {
    private let userDefaults = UserDefaults.standard
    private let key = "teams"

    private var teams: [Team]

    init() {
        if let teams = userDefaults.object(forKey: key) as? [Team] {
            self.teams = teams
        } else {
            teams = []
        }
    }

    public func createTeam(_ team: Team) {
        if self.teams.first(where: { $0 == team }) == nil {
            self.teams.append(team)
            userDefaults.set(self.teams, forKey: key)
        }
    }

    public func getLeaderboard() -> [Team] {
        self.teams
    }

    public func updateLeaderboard(teams: [Team]) {
        for index in 0..<self.teams.count {
            if let team = teams.first(where: { $0.id == self.teams[index].id }) {
                self.teams[index].teamScore += team.teamScore
            }
        }
        userDefaults.set(self.teams, forKey: key)
    }

    public func updateTeamName(team: Team, newName: String) {
        if let index = self.teams.firstIndex(where: { $0.id == team.id }) {
            self.teams[index].teamName = newName
            userDefaults.set(self.teams, forKey: key)
        } else {
            fatalError("Team to rename not found")
        }
    }

    public func deleteTeams() {
        userDefaults.removeObject(forKey: key)
    }
}
