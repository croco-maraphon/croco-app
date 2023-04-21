//
//  TeamsViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import UIKit
import SnapKit

class TeamsViewController: UIViewController {
    
    private var team = TeamAPI.getTeams()
    private var newTeam = TeamAPI.addTeam()
    private let teamsTable: TeamsTableView = TeamsTableView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureViewController()
        conformProtocols()
        addTeamButtonPressed()
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
    
    // добавление команды
    private func addTeamButtonPressed() {
        teamsTable.addTeamButton.addTarget(self, action: #selector(addTeam), for: .touchUpInside)
    }
    
    @objc func addTeam() {
        if team.count < 4 {
            team.append(newTeam[(0..<newTeam.count).randomElement()!])
            teamsTable.tableView.beginUpdates()
            teamsTable.tableView.insertRows(at: [(NSIndexPath(row: team.count - 1, section: 0) as IndexPath)],
                                            with: .automatic)
            teamsTable.tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDataSource
extension TeamsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellIdentifier, for: indexPath) as! TeamTableViewCell
        
        let canDelete = team.count > 2
        if canDelete {
            cell.deleteTeamButton.setBackgroundImage(UIImage(named: "crossImage"), for: .normal)
        } else {
            cell.deleteTeamButton.setBackgroundImage(nil, for: .normal)
        }
        
        cell.team = team[indexPath.row]
        cell.deleteTeamButton.addTarget(self, action: #selector(deleteTeam), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteTeam(indexPath: IndexPath) {
        team.remove(at: indexPath.row)
        teamsTable.tableView.beginUpdates()
        teamsTable.tableView.deleteRows(at: [indexPath], with: .automatic)
        teamsTable.tableView.endUpdates()
    }
}

// MARK: - UITableViewDelegate
extension TeamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let canDelete = team.count > 2
        return canDelete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            team.remove(at: indexPath.row)
            teamsTable.tableView.beginUpdates()
            teamsTable.tableView.deleteRows(at: [indexPath], with: .automatic)
            teamsTable.tableView.endUpdates()
        }
    }
}
