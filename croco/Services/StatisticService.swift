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

    public func getDictionary() -> [String: Int] {
        let dictionary = UserDefaults.standard.dictionaryRepresentation()

        let filteredDictionary = dictionary.filter { (key, value) -> Bool in
            return key.hasPrefix("croco ")
        }

        let prefixToRemove = "croco "
        var updatedDictionary: [String: Int] = [:]

        filteredDictionary.forEach { (key, value) in
            if let intValue = value as? Int {
                if key.hasPrefix(prefixToRemove) {
                    let newKey = String(key.dropFirst(prefixToRemove.count))
                    updatedDictionary[newKey] = intValue
                } else {
                    updatedDictionary[key] = intValue
                }
            }
        }

        return updatedDictionary
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
