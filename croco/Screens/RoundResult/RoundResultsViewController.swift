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
    private var currentTeamScore: [Team] = []
    private var playingCommands: [Team] = StatisticService().getTeams()
    private var currentCommand: Team?
    private var nextCommand: Team?
    private var numberOfRound = 0
    private let audioService = AudioService.shared
    
    var maxCurrentScore = 5
    
    var isWinRound: Bool?
    var reset: (() -> ())?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCommand = playingCommands[numberOfRound]
        nextRound()
        nextCommand = playingCommands[numberOfRound + 1]
        
        setViews()
        setConstraints()
        showResult(result: isWinRound)
        checkCurrentScore(maxCurrentScore)
    }
    
    func showResult(result: Bool?) {
        guard let result = result else { return }
        switch result {
        case true:
            roundResultView.midImageView.backgroundColor = UIColor(hexString: "74A730")
            roundResultView.topTeamLabel.text = currentCommand?.teamName
            roundResultView.topTeamImageLabel.text = currentCommand?.teamImage
            roundResultView.winOrLooseLabel.text = "Поздравляем!"
            roundResultView.getPointOrNotLabel.text = "Вы получаете"
            roundResultView.pointsImage.image = UIImage(named: "Vector")
            addScore(result: result)
//            addScoreTo(team: currentCommand)
        case false:
            roundResultView.midImageView.backgroundColor = UIColor(hexString: "E64546")
            roundResultView.topTeamLabel.text = currentCommand?.teamName
            roundResultView.topTeamImageLabel.text = currentCommand?.teamImage
            roundResultView.winOrLooseLabel.text = "УВЫ И АХ!"
            roundResultView.topTeamNumberLabel.text = "2"
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
    
    private func checkCurrentScore(_ score: Int) {
//        if team.teamScore == 5 {
        if score == 5 {
            roundResultView.getPointOrNotLabel.text = "Вы выйграли!"
            roundResultView.getPointOrNotLabel.font = UIFont.boldSystemFont(ofSize: 16)
            roundResultView.topScoreLabel.text = ""
            roundResultView.bottomScoreLabel.text = ""
            roundResultView.nextTurnLabel.text = "Вы можете посмотреть результаты"
            roundResultView.nextTurnButton.setTitle("Посмотреть результаты", for: .normal)
            roundResultView.nextTurnButton.addTarget(self, action: #selector(switchToGameResultViewController),
                                                     for: .touchUpInside)
        } else {
            roundResultView.nextTurnButton.setTitle("Следующий ход - Стройняшки", for: .normal)
            roundResultView.nextTurnButton.addTarget(self, action: #selector(swithToGameViewController), for: .touchUpInside)
        }
    }
    
    private func nextRound() {
        if numberOfRound + 1 != playingCommands.count {
            numberOfRound += 1
        } else {
            numberOfRound = 0
        }
    }
    
    
    @objc private func swithToGameViewController() {
        audioService.player?.stop()
        reset?()
        MainCoordinator.shared.push(.Game(teams: currentTeamScore))
    }

    @objc private func switchToGameResultViewController() {
        audioService.player?.stop()
        MainCoordinator.shared.push(.Results)
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
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            
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


