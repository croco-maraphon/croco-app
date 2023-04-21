//
//  ResultsViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import Foundation
import UIKit
import SnapKit

class GameResultViewController: UIViewController {
    
    let resultView = GameResultView()
    var teams = TeamsViewController().team
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.tableView.delegate = self
        resultView.tableView.dataSource = self
                
        setViews()
        setConstraints()
        setTargets()
    }
    private func setTargets() {
        resultView.resetButton.addTarget(self, action: #selector(switchToTeamsViewController), for: .touchUpInside)
    }
    
    @objc private func switchToTeamsViewController() {
        MainCoordinator.shared.push(.Teams)
    }
}

extension GameResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        124
    }
}

extension GameResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GameResultCell()
        cell.team = teams[indexPath.row]
        
        return cell
    }
}

extension GameResultViewController {
    private func setViews() {
        view.addSubview(resultView.backgroundImage)
        view.addSubview(resultView.resultLabel)
        view.addSubview(resultView.tableView)
        view.addSubview(resultView.resetButton)
    }
    
    private func setConstraints() {
        resultView.backgroundImage.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        resultView.resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        resultView.tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(resultView.resultLabel.snp.bottom).offset(38)
            make.bottom.equalTo(resultView.resetButton).inset(100)
        }
            
        resultView.resetButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(62)
        }
    }
}
