//
//  GameViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class GameViewController: UIViewController {
    
    private let gameView = GameView()
    private let audioService = AudioService.shared
    private let gameManager = GameManager.shared
    private let label = CategoriesPresenter.shared.getWordToPlay()
    private let statisticService = StatisticService.shared
    
    var timer = Timer()
    var secondRemaining = 60
    
    private var teams: [Team] = []
    private var currentCommand: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        teams = statisticService.getTeams()
        setGameView()
        correctButtonPressed()
        wrongButtonPressed()
        mainButtonPressed()
        
        currentCommand = teams[gameManager.getNumberOfRound()]
        startRound()
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gameView.frame = view.bounds
        view.addSubview(gameView)
    }
    
    public func setGameView() {
        self.view.addSubview(gameView)
        
        gameView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        gameView.wordLabel.text = label
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateTimer() {
        secondRemaining -= 1
        
        if secondRemaining == 0 {
            stopSound()
            navigateToWrong()
            return
        }
        
        if secondRemaining == 10 {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.enableCounter()
            }
        }
        
        if secondRemaining > 9 {
            gameView.timerLabel.text = "00:\(secondRemaining)"
        } else if secondRemaining >= 0 {
            gameView.timerLabel.text = "00:0\(secondRemaining)"
        }
    }
    
    // переход на CorrectViewController
    private func correctButtonPressed() {
        gameView.correctButton.addTarget(self, action: #selector(navigateToCorrect), for: .touchUpInside)
    }
    
    func startRound() {
        secondRemaining = 60
        startTimer()
        setupTeamInfo()
    }
    
    @objc func navigateToCorrect() {
        stopSound()
        timer.invalidate()
        audioService.makeSound(sound: .correctAnswer)
        statisticService.addScoreTo(team: currentCommand!)
        MainCoordinator.shared.push(.RoundResults(correct: true))
    }
    
    // переход на WrongViewController
    private func wrongButtonPressed() {
        gameView.wrongButton.addTarget(self, action: #selector(navigateToWrong), for: .touchUpInside)
    }
    
    @objc func navigateToWrong() {
        stopSound()
        timer.invalidate()
        audioService.makeSound(sound: .wrongAnswer)
        MainCoordinator.shared.push(.RoundResults(correct: false))
    }
    
    // переход на MainViewController
    private func mainButtonPressed() {
        gameView.mainButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Сбросить игру?",
                                      message: "Вы хотите сбросить вашу игру и вернуться в главное меню?",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.navigateToMain()
        }
        yesAction.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func enableCounter() {
        audioService.makeSound(sound: .counter)
    }
    
    private func stopSound() {
        audioService.player?.stop()
    }
    
    func navigateToMain() {
        self.timer.invalidate()
        stopSound()
        MainCoordinator.shared.popToRoot()
    }
    
    func setupTeamInfo() {
        guard let currentCommand = currentCommand else { return }
        gameView.currentTeamLabel.text = "Ход команды - \(currentCommand.teamName)"
        gameView.currentTeamImageLabel.text = currentCommand.teamImage
    }
}

