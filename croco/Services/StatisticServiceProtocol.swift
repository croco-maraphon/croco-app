//
//  StatisticServiceProtocol.swift
//  croco
//
//  Created by Ramil Yanberdin on 18.04.2023.
//

import Foundation

protocol StatisticServiceProtocol {
    func getPointsFrom(team: String) -> Int
    func setPointsTo(team: String, points: Int)
    func restore()
}
