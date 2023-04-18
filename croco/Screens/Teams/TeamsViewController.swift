//
//  TeamsViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import Foundation
import UIKit
import SnapKit

class TeamsViewController: UIViewController {
    
    private let teamsView = TeamsView.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViews()
        setConstraints()
    }
}

extension TeamsViewController {
    private func setViews() {
        view.addSubview(teamsView.backgroundImage)
        
        teamsView.topTeamView.addSubview(teamsView.topTeamImage)
        teamsView.topTeamView.addSubview(teamsView.topTeamLabel)
        
        teamsView.bottomTeamView.addSubview(teamsView.bottomTeamImage)
        teamsView.bottomTeamView.addSubview(teamsView.bottomTeamLabel)
        
        view.addSubview(teamsView.topTeamView)
        view.addSubview(teamsView.bottomTeamView)
        view.addSubview(teamsView.readyButton)
    }
    
    private func setConstraints() {
        teamsView.backgroundImage.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    
        teamsView.topTeamView.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(36)
        }
        
        teamsView.topTeamImage.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(17)
        }
        
        teamsView.topTeamLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        teamsView.bottomTeamView.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(teamsView.topTeamView.snp.bottom).inset(-36)
        }
        
        teamsView.bottomTeamImage.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(17)
        }
        
        teamsView.bottomTeamLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        teamsView.readyButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(62)
        }
    }
        
    private func setNavigationBar() {
        navigationItem.title = "Кто играет?"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34)]
    }
}
