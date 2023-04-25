//
//  RoundResultsViewController.swift
//  croco
//
//  Created by Евгений on 18.04.2023.
//

import UIKit
import SwiftUI
import SnapKit

class RoundResultsViewController: UIViewController {
    
    private var roundResultView = RoundResultsView()
    private let audioService = AudioService.shared
    private let gameManager = GameManager.shared
    private let statisticService = StatisticService.shared
    private var teams: [Team] = []
    private var currentCommand: Team?
    private var nextCommand: Team?
    private var numberOfRound = 0
   
    var isWinRound: Bool?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfRound = gameManager.getNumberOfRound()
        teams = statisticService.getTeams()
        currentCommand = teams[numberOfRound]
        nextCommand = gameManager.getNextTeam()
        
        setViews()
        setConstraints()
        
        showResult(result: isWinRound)
        checkCurrentScore(nextCommand)
        gameManager.nextRound()
    }
    
    func showResult(result: Bool?) {
        guard let result = result,
              let currentCommand = currentCommand else {
            print("else in showresult")
            return }
        
        print("teamscore - \(currentCommand.teamScore)")
        switch result {
        case true:
            addScore(result: result)
            roundResultView.midImageView.backgroundColor = UIColor(hexString: "74A730")
            roundResultView.topTeamLabel.text = currentCommand.teamName
            roundResultView.topTeamImageLabel.text = currentCommand.teamImage
            roundResultView.topTeamNumberLabel.text = String(currentCommand.teamScore)
            roundResultView.winOrLooseLabel.text = "Поздравляем!"
            roundResultView.getPointOrNotLabel.text = "Вы получаете"
            roundResultView.pointsImage.image = UIImage(named: "Vector")
        case false:
            roundResultView.midImageView.backgroundColor = UIColor(hexString: "E64546")
            roundResultView.topTeamLabel.text = currentCommand.teamName
            roundResultView.topTeamImageLabel.text = currentCommand.teamImage
            roundResultView.topTeamNumberLabel.text = String(currentCommand.teamScore)
            roundResultView.winOrLooseLabel.text = "УВЫ И АХ!"
            roundResultView.getPointOrNotLabel.text = "Вы не отгадали слово и не получаете очков!"
            roundResultView.pointsImage.image = UIImage(named: "Ellipse 2")
            addScore(result: result)
        }
    }
    
    private func addScore(result: Bool) {
        roundResultView.midImageView.addSubview(roundResultView.topScoreLabel)
        roundResultView.topScoreLabel.snp.makeConstraints { make in
            make.center.equalTo(roundResultView.pointsImage)
        }
        
        switch result {
        case true:
            roundResultView.midImageView.addSubview(roundResultView.bottomScoreLabel)
            roundResultView.bottomScoreLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(roundResultView.pointsImage.snp.bottom).inset(10)
            }
            roundResultView.topScoreLabel.text = "1"
            roundResultView.bottomScoreLabel.text = "ОЧКИ"
        case false:
            roundResultView.topScoreLabel.text = "0"
        }
    }
    
    private func checkCurrentScore(_ nextTeam: Team?) {
        guard let nextTeam = nextTeam,
              let currentCommand = currentCommand else { return }
        if currentCommand.teamScore == 5 {
            roundResultView.getPointOrNotLabel.text = "Вы выйграли!"
            roundResultView.getPointOrNotLabel.font = UIFont.boldSystemFont(ofSize: 16)
            roundResultView.topScoreLabel.text = ""
            roundResultView.bottomScoreLabel.text = ""
            roundResultView.nextTurnLabel.text = "Вы можете посмотреть результаты"
            roundResultView.nextTurnButton.setTitle("Посмотреть результаты", for: .normal)
            roundResultView.nextTurnButton.addTarget(self, action: #selector(switchToGameResultViewController),
                                                     for: .touchUpInside)
        } else {
            print("елсе блок в чеккурент")
            roundResultView.nextTurnLabel.text = "Следующий ход - \(nextTeam.teamName)"
            roundResultView.nextTurnButton.setTitle("Передать ход", for: .normal)
            roundResultView.nextTurnButton.addTarget(self, action: #selector(swithToGameViewController), for: .touchUpInside)
        }
    }
    
    
    @objc private func swithToGameViewController() {
        audioService.player?.stop()
        navigationController?.pushViewController(GameViewController(), animated: true)
    }

    @objc private func switchToGameResultViewController() {
        let statisticService = StatisticService()
        let teams = statisticService.getTeams()
        statisticService.updateLeaderboard(gameResult: teams)
        audioService.player?.stop()
        
        navigationController?.pushViewController(GameResultViewController(), animated: true)
    }
}
    

extension RoundResultsViewController {
    private func setViews() {
        view.addSubview(roundResultView.backgroundImage)
        view.addSubview(roundResultView.topTeamView)
        
        roundResultView.topTeamView.addSubview(roundResultView.topTeamImageLabel)
        roundResultView.topTeamView.addSubview(roundResultView.topTeamLabel)
        roundResultView.topTeamView.addSubview(roundResultView.topTeamNumberLabel)
        roundResultView.topTeamView.addSubview(roundResultView.topTeamScoreLabel)
        
        roundResultView.midImageView.addSubview(roundResultView.winOrLooseLabel)
        roundResultView.midImageView.addSubview(roundResultView.getPointOrNotLabel)
        roundResultView.midImageView.addSubview(roundResultView.pointsImage)
        roundResultView.midImageView.addSubview(roundResultView.topScoreLabel)
        roundResultView.midImageView.addSubview(roundResultView.nextTurnLabel)
        
        view.addSubview(roundResultView.midImageView)
        view.addSubview(roundResultView.nextTurnButton)
    }
    
    private func setConstraints() {
        roundResultView.backgroundImage.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        // Top UI-block:
        roundResultView.topTeamView.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(80)
        }
        
        roundResultView.topTeamImageLabel.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(17)
        }
        
        roundResultView.topTeamLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        roundResultView.topTeamNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(11)
            make.width.height.equalTo(70)
        }
        
        roundResultView.topTeamScoreLabel.snp.makeConstraints { make in
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        // Mid UI-block
        roundResultView.midImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(301)
            make.center.equalToSuperview()
        }
        
        roundResultView.winOrLooseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(43)
            make.centerX.equalToSuperview()
        }
        
        roundResultView.getPointOrNotLabel.snp.makeConstraints { make in
            make.top.equalTo(roundResultView.winOrLooseLabel).inset(35)
            make.centerX.equalToSuperview()
        }
        
        roundResultView.pointsImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(110)
        }
        
        roundResultView.nextTurnLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        roundResultView.nextTurnButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(62)
        }
    }
}


