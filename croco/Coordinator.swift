//
//  Coordinator.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
    
    func push(_ vc: Screens)
    func pop()
}

enum Screens {
    case Main
    case Rules
    case Teams
    case Categories
    case Game(team: Team)
    case Results
    case RoundResults(correct: Bool)
    case LeaderBoard
    
    var controller: UIViewController {
        switch self {
        case .Main:
            return MainViewController()
        case .Rules:
            return RulesViewController()
        case .Teams:
            return TeamsViewController()
        case .Categories:
            return CategoriesViewController()
        case .Game(let team):
            let controller = GameViewController()
            controller.currentCommand = team
            return controller
        case .Results:
            return GameResultViewController()
        case .RoundResults(let correct):
            let controller = RoundResultsViewController()
            controller.isWinRound = correct
            return controller
        case .LeaderBoard:
            return LeaderBoardViewController()
        }
    }
}

class MainCoordinator: Coordinator {
    public static let shared = MainCoordinator()

    var navigationController: UINavigationController = UINavigationController()
    
    
    func start() {
        let vc = MainViewController()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func push(_ path: Screens) {
        navigationController.pushViewController(path.controller, animated: true)
    }
            
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
