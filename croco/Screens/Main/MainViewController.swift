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
        
    var block1 = UIView()
    var block2 = UIView()
    var block3 = UIView()
    
    var startGameButton = UIButton()
    var rulesButton = UIButton()
    var resultButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackground()
        setupViews()
        setupConstraints()
        logo()
        addGrass()
        setupGameButton()
        setupRulesButton()
        setupResultButton()
        clearBackButtonTitle() 
    }
    
    func setupViews() {
        view.addSubview(block1)
        view.addSubview(block2)
        view.addSubview(block3)
    }
    
    func setupConstraints() {
        block1.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(block2)
        }
        
        block2.snp.makeConstraints { (make) in
            make.top.equalTo(block1.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(block1)
        }
        
        block3.snp.makeConstraints { (make) in
            make.top.equalTo(block2.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(70)
        }
    }
    
    
    public func logo() {
        let croco = UIImage(named: "croco")
        
        guard let croco = croco else {
            fatalError("croco image is empty");
        }
        
        let imageView = UIImageView(image: croco)
        imageView.contentMode = .scaleAspectFit
        
        block1.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(block1)
        }
    }
    
    public func addGrass() {
        let grass = UIImage(named: "grass")
        
        guard let grass = grass else {
            fatalError("grass image is empty")
        }
        
        let imageViewGrass1 = UIImageView(image: grass)
        let imageViewGrass2 = UIImageView(image: grass)
        
        imageViewGrass1.contentMode = .scaleAspectFit
        imageViewGrass2.contentMode = .scaleAspectFit
        
        block3.addSubview(imageViewGrass1)
        block3.addSubview(imageViewGrass2)
        
        imageViewGrass1.snp.makeConstraints { make in
            make.height.equalTo(block3)
            make.left.bottom.equalTo(block3)
        }
        
        imageViewGrass2.snp.makeConstraints { make in
            make.height.equalTo(block3)
            make.right.bottom.equalTo(block3)
        }
    }
    
    public func setupGameButton() {
        startGameButton.setTitle("Старт игры", for: .normal)
        startGameButton.layer.masksToBounds = true
        startGameButton.layer.cornerRadius = 10
        startGameButton.titleLabel?.font = UIFont.systemFont(
            ofSize: 20,
            weight: .regular
        )
        startGameButton.backgroundColor = UIColor(red: 0.45, green: 0.65, blue: 0.19, alpha: 1.0)
        
        block2.addSubview(startGameButton)
        
        startGameButton.snp.makeConstraints { make in
            make.top.equalTo(block2).inset(54)
            make.left.right.equalTo(view).inset(50)
            make.height.equalTo(80)
        }
        
        startGameButton.addTarget(self, action: #selector(navigateToTeams), for: .touchUpInside)
    }
    
    func setupRulesButton() {
        rulesButton.setTitle("Правила", for: .normal)
        rulesButton.layer.masksToBounds = true
        rulesButton.layer.cornerRadius = 10
        rulesButton.titleLabel?.font = UIFont.systemFont(
            ofSize: 17,
            weight: .regular
        )
        rulesButton.backgroundColor = UIColor(red: 0.45, green: 0.65, blue: 0.19, alpha: 1.0)
        
        block2.addSubview(rulesButton)
        
        rulesButton.snp.makeConstraints { make in
            make.top.equalTo(startGameButton.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(80)
            make.height.equalTo(60)
        }
        
        rulesButton.addTarget(self, action: #selector(navigateToRules), for: .touchUpInside)
    }
    
    func setupResultButton(){
        resultButton.setTitle("Результат", for: .normal)
        resultButton.layer.masksToBounds = true
        resultButton.layer.cornerRadius = 10
        resultButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        resultButton.backgroundColor = UIColor(red: 250/255, green: 120/255, blue: 0, alpha: 1)
        block2.addSubview(resultButton)
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(rulesButton.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(80)
            make.height.equalTo(60)
        }
        
        resultButton.addTarget(self, action: #selector(navigateToResult), for: .touchUpInside)
    }
        
    public func setBackground() {
        let background = UIImage(named: "background")
        
        guard let background = background else {
            fatalError("background image is empty");
        }
        
        let imageView = UIImageView(image: background)
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view)
        }
    }
        
    @objc func navigateToRules() {
        MainCoordinator.shared.push(.Rules)
    }
    
    @objc func navigateToTeams() {
        MainCoordinator.shared.push(.Teams)
    }
    
    @objc func navigateToResult() {
        MainCoordinator.shared.push(.LeaderBoard)
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
        //            .colorScheme(.light) // or .dark
    }
}

extension MainViewController {
    private func clearBackButtonTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: ""
        )
    }
}
