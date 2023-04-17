//
//  MainViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class MainViewController: UIViewController {
    
    var rulesButton: UIButton = UIButton()
    var teamsButton: UIButton = UIButton()
    var gameButton: UIButton = UIButton()
    var categoriesButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackground()
        setTitle()
        setRulesButton()
        setTeamsButton()
        setGameButton()
        setCategoriesButton()
        clearBackButtonTitle()
    }
    
    public func setBackground() {
        self.view.backgroundColor = .white
    }
    
    public func setTitle() {
        let label = UILabel()
        label.text = "Main View Controller"
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
        
    private func setRulesButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.background.backgroundColor = UIColor.systemBlue
        rulesButton.configuration = configuration
        
        rulesButton.setTitle("go to rules", for: .normal)
                
        self.view.addSubview(rulesButton)
        
        rulesButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(200)
        }
        
        rulesButton.addTarget(self, action: #selector(navigateToRules), for: .touchUpInside)
    }
    
    private func setTeamsButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.background.backgroundColor = UIColor.systemBlue
        teamsButton.configuration = configuration
        
        teamsButton.setTitle("go to teams", for: .normal)
                
        self.view.addSubview(teamsButton)
        
        teamsButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.rulesButton.snp.top).offset(-20)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(200)
        }
        
        teamsButton.addTarget(self, action: #selector(navigateToTeams), for: .touchUpInside)
    }
    
    private func setGameButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.background.backgroundColor = UIColor.systemBlue
        gameButton.configuration = configuration
        
        gameButton.setTitle("go to game", for: .normal)
                
        self.view.addSubview(gameButton)
        
        gameButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.teamsButton.snp.top).offset(-20)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(200)
        }
        
        gameButton.addTarget(self, action: #selector(navigateToGame), for: .touchUpInside)
    }
    
    @objc func navigateToGame() {
        MainCoordinator.shared.push(.Game)
    }
    
    @objc func navigateToRules() {
        MainCoordinator.shared.push(.Rules)
    }
    
    @objc func navigateToTeams() {
        MainCoordinator.shared.push(.Teams)
    }
 
}

struct ContentMainViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = MainViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        return MainViewController()
    }

    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {}
}

struct ContentMainViewController_Previews: PreviewProvider {
    static var previews: some View {
        ContentMainViewController()
            .previewInterfaceOrientation(.portrait)
            .edgesIgnoringSafeArea(.all)
            .colorScheme(.light) // or .dark
    }
}

extension MainViewController {
    private func setCategoriesButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.background.backgroundColor = UIColor.systemBlue
        categoriesButton.configuration = configuration

        categoriesButton.setTitle("go to categories", for: .normal)

        self.view.addSubview(categoriesButton)

        categoriesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            categoriesButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        categoriesButton.addTarget(self, action: #selector(navigateToCategories), for: .touchUpInside)
    }

    @objc func navigateToCategories() {
        MainCoordinator.shared.push(.Categories)
    }
}

extension MainViewController {
    private func clearBackButtonTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: ""
        )
    }
}
