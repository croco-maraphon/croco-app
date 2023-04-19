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
        secondRemaining -= 1
        
        if secondRemaining == 0 {
            navigateToWrong()
            return
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
    
    @objc func navigateToCorrect() {
        let viewController = RoundResultsViewController()
        viewController.modalPresentationStyle = .overFullScreen
        viewController.isWin = true
        
        present(viewController, animated: true)
    }
    
    // переход на WrongViewController
    private func wrongButtonPressed() {
        gameView.wrongButton.addTarget(self, action: #selector(navigateToWrong), for: .touchUpInside)
    }
    
    @objc func navigateToWrong() {
        let viewController = RoundResultsViewController()
        viewController.modalPresentationStyle = .overFullScreen
        viewController.isWin = false
        
        present(viewController, animated: true)
        
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
    
    func navigateToMain() {
        MainCoordinator.shared.start()
    }
}
