//
//  StatisticService.swift
//  croco
//
//  Created by Ramil Yanberdin on 18.04.2023.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let userDefaults = UserDefaults.standard

    public func getPointsFrom(team: String) -> Int {
        userDefaults.integer(forKey: team)
    }

    public func setPointsTo(team: String, points: Int) {
        userDefaults.set(points, forKey: team)
    }

    public func restorePoints() {
        let dictionary = userDefaults.dictionaryRepresentation()

        dictionary.keys.forEach {
            userDefaults.removeObject(forKey: $0)
        }
    }
}
