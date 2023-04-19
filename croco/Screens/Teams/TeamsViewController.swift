//
//  TeamsViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import UIKit
import SnapKit

class TeamsViewController: UIViewController {
    
    private let team = TeamAPI.getTeam()
    private let teamsTable: TeamsTableView = TeamsTableView()

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureViewController()
        conformProtocols()
        playersReadyButtonPressed()
    }
    
    override func loadView() {
        self.view = teamsTable
    }
    
    // MARK: - Private Methods
    private func registerCells() {
        teamsTable.tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.cellIdentifier)
    }
    
    private func configureViewController() {       
        let label = UILabel()
        label.text = "Кто играет?"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        navigationItem.titleView = label
    }
    
    private func conformProtocols() {
        teamsTable.tableView.dataSource = self
        teamsTable.tableView.delegate = self
    }
    
    private func addViews() {
        view.addSubview(teamsTable)
    }
    
    private func addConstraints() {
        teamsTable.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // переход на CategoriesViewController
    private func playersReadyButtonPressed() {
        teamsTable.playersReadyButton.addTarget(self, action: #selector(navigateToCategories), for: .touchUpInside)
    }
    
    @objc func navigateToCategories() {
        MainCoordinator.shared.push(.Categories)
    }
}

// MARK: - UITableViewDataSource
extension TeamsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellIdentifier,
                                                 for: indexPath) as! TeamTableViewCell
        cell.team = team[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TeamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}
