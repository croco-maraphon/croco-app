//
//  GameManager.swift
//  croco
//
//  Created by Евгений on 25.04.2023.
//

final class GameManager {
    
    static let shared = GameManager()
    
    private var numberOfRound = 0
    var teams = StatisticService().getTeams()
    
    func nextRound() {
        if numberOfRound + 1 != teams.count {
            numberOfRound += 1
        } else {
            restartGame()
        }
    }
    
    private func restartGame() {
        numberOfRound = 0
    }
    
    func getNextTeam() -> Team {
        if numberOfRound + 1 != teams.count {
            return teams[numberOfRound + 1]
        } else {
            return teams[0]
        }
    }
    
    func getNumberOfRound() -> Int {
        numberOfRound
    }
}
