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
        userDefaults.integer(forKey: "croco \(team)")
    }

    public func setPointsTo(team: String, points: Int) {
        userDefaults.set(points, forKey: "croco \(team)")
    }

    public func restore() {
        let keys = userDefaults.dictionaryRepresentation().keys

        for key in keys {
            if key.hasPrefix("croco ") {
                userDefaults.removeObject(forKey: key)
            }
        }
        userDefaults.synchronize()
    }
}
