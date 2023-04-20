//
//  StatisticServiceTest.swift
//  StatisticServiceTest
//
//  Created by Ramil Yanberdin on 20.04.2023.
//

import XCTest
@testable import croco

final class StatisticServiceTest: XCTestCase {
    let statisticService = StatisticService()
    let userdefaults = UserDefaults.standard
    let prefix = "croco "

    let firstGame: [TeamModel] = [
        .init(
            teamName: "TeamOne",
            teamImage: UIImage(),
            teamScore: 1),
        .init(
            teamName: "TeamTwo",
            teamImage: UIImage(),
            teamScore: 2),
        .init(
            teamName: "TeamThree",
            teamImage: UIImage(),
            teamScore: 3),
    ]

    let secondGame: [TeamModel] = [
        .init(
            teamName: "TeamOne",
            teamImage: UIImage(),
            teamScore: 5),
        .init(
            teamName: "TeamFour",
            teamImage: UIImage(),
            teamScore: 4)
    ]
    
    func testSendGameResult() throws {
        statisticService.sendGameResult(
            teams: firstGame
        )

        let scores = [userdefaults.integer(forKey: prefix + firstGame[0].teamName),
                      userdefaults.integer(forKey: prefix + firstGame[1].teamName),
                      userdefaults.integer(forKey: prefix + firstGame[2].teamName)]

        XCTAssertEqual([1, 2, 3], scores)

        statisticService.sendGameResult(teams: secondGame)

        let updatedScores = [userdefaults.integer(forKey: prefix + firstGame[0].teamName),
                             userdefaults.integer(forKey: prefix + firstGame[1].teamName),
                             userdefaults.integer(forKey: prefix + firstGame[2].teamName),
                             userdefaults.integer(forKey: prefix + secondGame[1].teamName)]

        XCTAssertEqual([6, 2, 3, 4], updatedScores)
    }

    func testGetLeaderBoard() throws {
        statisticService.sendGameResult(teams: firstGame)
        statisticService.sendGameResult(teams: secondGame)
        let dictionary = statisticService.getLeaderboard()

        XCTAssertEqual(4, dictionary.count)
    }

    func testRename() throws {
        statisticService.sendGameResult(teams: secondGame)
        statisticService.rename(team: secondGame[1], newName: "TeamFive")
        let keys = userdefaults.dictionaryRepresentation().keys

        XCTAssertTrue(keys.contains(prefix + "TeamFive"), "Ключ 'TeamFive' не найден в UserDefaults")
    }

    func testRestore() throws {
        statisticService.restore()
        let dictionary = statisticService.getLeaderboard()

        XCTAssertTrue(dictionary.count == 0)
    }

}
