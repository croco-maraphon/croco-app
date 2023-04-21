//
//  StatisticServiceTests.swift
//  StatisticServiceTests
//
//  Created by Ramil Yanberdin on 21.04.2023.
//

import XCTest
@testable import croco

final class StatisticServiceTests: XCTestCase {
    enum Keys: String {
        case teams, leaderboard
    }

    private let userDefaults = UserDefaults.standard
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

        if let data = getData(key: Keys.leaderboard),
           let team = try? JSONDecoder().decode(Team.self, from: data) {
            XCTAssertEqual(teamOne.id, team.id)
        }

        statistic.createTeam(teamTwo)

        if let data = getData(key: Keys.leaderboard),
           let team = getDecodedData(data) {
            XCTAssertTrue(team.count == 2)
        }

        if let data = getData(key: Keys.teams),
           let team = getDecodedData(data) {
            XCTAssertTrue(team.count == 2)
        }
        restore()
    }

    func testGetTeams() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)

        var firstGameResult: [Team] = [teamOne, teamTwo]
        firstGameResult[0].teamScore = 1
        firstGameResult[1].teamScore = 2
        statistic.updateLeaderboard(gameResult: firstGameResult)

        let teamThree = Team(
            teamName: "TeamThree",
            teamImage: "",
            teamScore: 3
        )
        var secondGameResult: [Team] = [teamOne, teamThree]
        secondGameResult[0].teamScore = 5
        secondGameResult[1].teamScore = 4
        statistic.updateLeaderboard(gameResult: secondGameResult)

        if let data = getData(key: Keys.teams),
           let team = getDecodedData(data) {
            XCTAssertNil(team.first(where: { $0.id == teamTwo.id }))
        }
        restore()

    }

    func testGetLeaderboard() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)

        if let data = getData(key: Keys.leaderboard),
           let team = getDecodedData(data) {
            XCTAssertTrue(team.count == 2)
        }
        restore()
    }

    func testUpdateLeaderboard() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)

        var gameResult: [Team] = [teamOne, teamTwo]
        gameResult[0].teamScore = 1
        gameResult[1].teamScore = 2

        statistic.updateLeaderboard(gameResult: gameResult)

        if let data = getData(key: Keys.leaderboard),
           let team = getDecodedData(data) {
            XCTAssertEqual(team[0].teamScore, 2)
            XCTAssertEqual(team[1].teamScore, 4)
        }
        restore()
    }

    func testUpdateTeamName() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)
        let newName = "TeamZero"

        statistic.updateTeamName(team: teamOne, newName: newName)

        if let data = getData(key: Keys.leaderboard),
           let team = getDecodedData(data) {
            XCTAssertEqual(team[0].teamName, newName)
        }
        restore()
    }

    func testDeleteTeam() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)

        statistic.deleteTeam(teamTwo)

        if let data = getData(key: Keys.teams),
           let team = getDecodedData(data) {
            XCTAssertNil(team.first(where: { $0 == teamTwo }))
            XCTAssertNotNil(team.first(where: { $0 == teamOne }))
        }

        if let data = getData(key: Keys.leaderboard),
           let team = getDecodedData(data) {
            XCTAssertTrue(team.count == 2)
        }
        restore()
    }

    func testRestoreLeaderboard() throws {
        statistic.createTeam(teamOne)
        statistic.createTeam(teamTwo)

        statistic.restoreLeaderboard()

        let data = getData(key: Keys.leaderboard)
        XCTAssertNil(data)
    }

    private func getData(key: Keys) -> Data? {
        userDefaults.object(forKey: key.rawValue) as? Data
    }

    private func getDecodedData(_ data: Data) -> [Team]? {
        let team = try? JSONDecoder().decode([Team].self, from: data)
        return team
    }

    private func restore() {
        userDefaults.removeObject(forKey: Keys.teams.rawValue)
        userDefaults.removeObject(forKey: Keys.leaderboard.rawValue)
    }
}
