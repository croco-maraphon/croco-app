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
    private let userDefaults = UserDefaults.standard
    private let key = "teams"

    private var teams: [Team]

    init() {
        if let data = userDefaults.object(forKey: key) as? Data,
           let teams = try? JSONDecoder().decode([Team].self,from: data) {
            self.teams = teams
        } else {
            teams = []
        }
    }

    public func createTeam(_ team: Team) {
        if self.teams.first(where: { $0 == team }) == nil {
            self.teams.append(team)
            setData()
        }
    }

    public func getLeaderboard() -> [Team] {
        self.teams
    }

    public func updateLeaderboard(gameResult: [Team]) {
        for index in 0..<self.teams.count {
            if let team = gameResult.first(where: { $0.id == self.teams[index].id }) {
                self.teams[index].teamScore += team.teamScore
            }
        }
        setData()
    }

    public func updateTeamName(team: Team, newName: String) {
        if let index = self.teams.firstIndex(where: { $0.id == team.id }) {
            self.teams[index].teamName = newName

            setData()
        } else {
            fatalError("Team to rename not found")
        }
    }

    public func deleteTeams() {
        userDefaults.removeObject(forKey: key)
    }

    private func setData() {
        if let encode = try? JSONEncoder().encode(self.teams) {
            userDefaults.set(encode, forKey: key)
        }
    }
}
