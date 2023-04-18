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
    
    let label = CategoriesPresenter.shared.getWordToPlay()
    
    var timer = Timer()
    var secondRemaining = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        setGameView()
        startTimer()
        correctButtonPressed()
        wrongButtonPressed()
        mainButtonPressed()
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
        if secondRemaining > 10 {
            secondRemaining -= 1
            gameView.timerLabel.text = "00:\(secondRemaining)"
        } else if secondRemaining > 0 {
            secondRemaining -= 1
            gameView.timerLabel.text = "00:0\(secondRemaining)"
        }
    }
    
    
    // переход на CorrectViewController
    private func correctButtonPressed() {
        gameView.correctButton.addTarget(self, action: #selector(navigateToCorrect), for: .touchUpInside)
        
    }
    
    @objc func navigateToCorrect() {
        MainCoordinator.shared.pop()
    }
    
    // переход на WrangViewController
    private func wrongButtonPressed() {
        gameView.wrongButton.addTarget(self, action: #selector(navigateToWrong), for: .touchUpInside)
        
    }
    
    @objc func navigateToWrong() {
        MainCoordinator.shared.pop()
    }
    
    // переход на MainViewController
    private func mainButtonPressed() {
        gameView.mainButton.addTarget(self, action: #selector(navigateToMain), for: .touchUpInside)
        
    }
    
    @objc func navigateToMain() {
        MainCoordinator.shared.pop()
    }
}
