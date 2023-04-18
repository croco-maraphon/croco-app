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
    
    private var roundResultView = RoundResultsView.shared
    
    var isWinRound: Bool = true
    var maxCurrentScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        showResult(result: isWinRound)
        checkCurrentScore(maxCurrentScore)
    }
    
    private func showResult(result: Bool) {
        switch result {
        case true:
            roundResultView.midImageView.backgroundColor = UIColor(hexString: "74A730")
            roundResultView.winOrLooseLabel.text = "Поздравляем"
            roundResultView.getPointOrNotLabel.text = "Вы получаете"
            roundResultView.pointsImage.image = UIImage(named: "Vector")
            addScore(result: result)
        case false:
            roundResultView.midImageView.backgroundColor = UIColor(hexString: "E64546")
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
        if score == 5 {
            roundResultView.nextTurnButton.setTitle("Посмотреть результаты", for: .normal)
            roundResultView.nextTurnButton.addTarget(self, action: #selector(switchToGameResultViewController),
                                                     for: .touchUpInside)
        } else {
            roundResultView.nextTurnButton.setTitle("Следующий ход - Стройняшки", for: .normal)
            roundResultView.nextTurnButton.addTarget(self, action: #selector(swithToGameViewController), for: .touchUpInside)
        }
    }
    
    @objc private func swithToGameViewController() {
        let viewController = GameViewController()
        viewController.modalPresentationStyle = .overFullScreen
        
        present(viewController, animated: true)
    }
    
    @objc private func switchToGameResultViewController() {
        let viewController = GameResultViewController()
        viewController.modalPresentationStyle = .overFullScreen
        
        present(viewController, animated: true)
    }
}

extension RoundResultsViewController {
    private func setViews() {
        view.addSubview(roundResultView.backgroundImage)
        view.addSubview(roundResultView.topTeamView)
        
        roundResultView.topTeamView.addSubview(roundResultView.topTeamImage)
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
        
        roundResultView.topTeamImage.snp.makeConstraints { make in
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


