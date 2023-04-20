//
//  StatisticService.swift
//  croco
//
//  Created by Ramil Yanberdin on 18.04.2023.
//

import Foundation

final class StatisticService {
    private let userDefaults = UserDefaults.standard
    private let prefix = "croco "

    public func getLeaderboard() -> [String: Int] {
        var leaderboard: [String: Int] = [:]
        let dictionary = userDefaults.dictionaryRepresentation()

        for key in dictionary.keys {
            if key.hasPrefix(prefix) {
                if let value = dictionary[key] as? Int {
                    let index = String(key.dropFirst(prefix.count))
                    leaderboard[index] = value
                }
            }
        }
        return leaderboard
    }

    public func sendGameResult(teams: [TeamModel]) {
        let leaderboard = getLeaderboard()

        for team in teams {
            if leaderboard.keys.contains(team.teamName) {
                let score = team.teamScore + userDefaults.integer(
                    forKey: prefix + team.teamName
                )
                userDefaults.set(
                    score,
                    forKey: prefix + team.teamName
                )
            } else {
                userDefaults.set(
                    team.teamScore,
                    forKey: prefix + team.teamName
                )
            }
        }
    }

    public func restore() {
        let keys = userDefaults.dictionaryRepresentation().keys

        for key in keys {
            if key.hasPrefix(prefix) {
                userDefaults.removeObject(forKey: key)
            }
        }
        userDefaults.synchronize()
    }

    public func rename(team: TeamModel, newName: String) {
        let leaderboard = getLeaderboard()

        if leaderboard.keys.contains(team.teamName) {
            let score = userDefaults.integer(
                forKey: prefix + team.teamName
            )
            userDefaults.removeObject(
                forKey: prefix + team.teamName
            )
            userDefaults.set(score, forKey: prefix + newName)
        } else {
            fatalError("Team not found")
        }
    }
}
