//
//  StatisticServiceTests.swift
//  StatisticServiceTests
//
//  Created by Ramil Yanberdin on 21.04.2023.
//

import XCTest
@testable import croco

final class StatisticServiceTests: XCTestCase {
    private let userDefaults = UserDefaults.standard
    private let key = "teams"
    private let statistic = StatisticService()

    private let teamOne = Team(
        teamName: "TeamOne",
        teamImage: "",
        teamScore: 1
    )

    private let teamTwo = Team(
        teamName: "TeamTwo",
        teamImage: "",
        teamScore: 2
    )

    func testCreateTeam() throws {
        statistic.createTeam(teamOne)

        if let data = getData(),
           let team = try? JSONDecoder().decode(Team.self, from: data) {
            XCTAssertEqual(teamOne.id, team.id)
        }

        statistic.createTeam(teamTwo)

        if let data = getData(),
           let team = getDecodedData(data) {
            XCTAssertTrue(team.count == 2)
        }
        statistic.deleteTeams()
    }

    func testGetLeaderboard() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)

        if let data = getData(),
           let team = getDecodedData(data) {
            XCTAssertTrue(team.count == 2)
        }
        statistic.deleteTeams()
    }

    func testUpdateLeaderboard() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)

        var gameResult: [Team] = [teamOne, teamTwo]
        gameResult[0].teamScore = 1
        gameResult[1].teamScore = 2

        statistic.updateLeaderboard(gameResult: gameResult)

        if let data = getData(),
           let team = getDecodedData(data) {
            XCTAssertEqual(team[0].teamScore, 2)
            XCTAssertEqual(team[1].teamScore, 4)
        }
        statistic.deleteTeams()
    }

    func testUpdateTeamName() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)
        let newName = "TeamZero"

        statistic.updateTeamName(team: teamOne, newName: newName)

        if let data = getData(),
           let team = getDecodedData(data) {
            XCTAssertEqual(team[0].teamName, newName)
        }
        statistic.deleteTeams()
    }

    func testDeleteTeams() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)

        statistic.deleteTeams()

        let data = getData()
        XCTAssertNil(data)
    }

    private func getData() -> Data? {
        userDefaults.object(forKey: key) as? Data
    }

    private func getDecodedData(_ data: Data) -> [Team]? {
        let team = try? JSONDecoder().decode([Team].self, from: data)
        return team
    }
}
