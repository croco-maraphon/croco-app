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
        case teams, leaderboard
    }

    private let userDefaults = UserDefaults.standard

    private var teams: [Team] = {
        if let data = UserDefaults.standard.object(forKey: Keys.teams.rawValue) as? Data,
           let teams = try? JSONDecoder().decode([Team].self,from: data) {
            return teams
        } else {
            return []
        }
    }()

    private var leaderboard: [Team] = {
        if let data = UserDefaults.standard.object(forKey: Keys.leaderboard.rawValue) as? Data,
           let leaderboard = try? JSONDecoder().decode([Team].self,from: data) {
            return leaderboard
        } else {
            return []
        }
    }()

    public func createTeam(_ team: Team) {
        addTeam(team, to: &teams, for: Keys.teams)
        addTeam(team, to: &leaderboard, for: Keys.leaderboard)
    }

    public func getTeams() -> [Team] {
        getData(key: Keys.teams)
    }

    public func getLeaderboard() -> [Team] {
        getData(key: Keys.leaderboard)
    }

    public func updateLeaderboard(gameResult: [Team]) {
        for index in 0..<leaderboard.count {
            if let team = gameResult.first(where: { $0.id == leaderboard[index].id }) {
                leaderboard[index].teamScore += team.teamScore
            }
        }
        setData(teams: leaderboard, key: Keys.leaderboard)
        setData(teams: gameResult, key: Keys.teams)
    }

    public func updateTeamName(team: Team, newName: String) {
        updateTeam(team, newName: newName, to: &teams, for: Keys.teams)
        updateTeam(team, newName: newName, to: &leaderboard, for: Keys.leaderboard)
    }

    public func deleteTeam(_ team: Team) {
        teams.removeAll(where: { $0.id == team.id })
        setData(teams: teams, key: Keys.teams)
    }

    public func restoreLeaderboard() {
        userDefaults.removeObject(forKey: Keys.leaderboard.rawValue)
    }

    private func setData(teams: [Team], key: Keys) {
        if let encode = try? JSONEncoder().encode(teams) {
            userDefaults.set(encode, forKey: key.rawValue)
        }
    }

    private func getData(key: Keys) -> [Team] {
        if let data = userDefaults.object(forKey: key.rawValue) as? Data,
           let teams = try? JSONDecoder().decode([Team].self, from: data) {
            return teams
        } else {
            return []
        }
    }

    private func addTeam(_ team: Team, to teams: inout [Team], for key: Keys) {
        if teams.first(where: { $0 == team }) == nil {
            teams.append(team)
            setData(teams: teams, key: key)
        }
    }

    private func updateTeam(_ team: Team, newName: String, to teams: inout [Team], for key: Keys) {
        if let index = teams.firstIndex(where: { $0.id == team.id }) {
            teams[index].teamName = newName
            setData(teams: teams, key: key)
        }
    }
}
