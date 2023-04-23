//
//  TeamsViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import UIKit
import SnapKit

class TeamsViewController: UIViewController {
    
    private var teams = TeamAPI.getTeams()
    private let teamsTable: TeamsTableView = TeamsTableView()

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureViewController()
        conformProtocols()
        addTeamButtonPressed()
        playersReadyButtonPressed()
        clearBackButtonTitle()
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
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
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
        if teams.count < 4 {
            let team = TeamAPI.addTeam()
            teams.append(team)
            teamsTable.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension TeamsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellIdentifier, for: indexPath) as! TeamTableViewCell
        
        let canDelete = teams.count > 2 && indexPath.row >= 2
        if canDelete {
            cell.deleteTeamButton.setBackgroundImage(UIImage(named: "crossImage"), for: .normal)
        } else {
            cell.deleteTeamButton.setBackgroundImage(nil, for: .normal)
        }
        
        cell.team = teams[indexPath.row]
        cell.deleteCallback = deleteTeam
        cell.indexPath = indexPath

        let view = UIView()
        view.backgroundColor = UIColor(hex: "#74A730")
        cell.selectedBackgroundView = view

        return cell
    }
    
    @objc func deleteTeam(indexPath: IndexPath) {
        guard indexPath.row < teams.count else { return }
        TeamAPI.deleteTeam(teams[indexPath.row])
        print("look on index path \(indexPath.row)")
        teams.remove(at: indexPath.row)
        teamsTable.tableView.beginUpdates()
        teamsTable.tableView.deleteRows(at: [indexPath], with: .automatic)
        teamsTable.tableView.reloadData()
        teamsTable.tableView.endUpdates()
    }
}

// MARK: - UITableViewDelegate
extension TeamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let canDelete = teams.count > 2
        return canDelete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTeam(indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let alertController = UIAlertController(title: "Изменить имя команды", message: "Введите новое имя для выбранной команды", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "Новое имя команды"
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { (_) in
            if let textField = alertController.textFields?.first, let newText = textField.text, !newText.isEmpty {
                self.teams[indexPath.row].teamName = newText
                tableView.reloadRows(at: [indexPath], with: .automatic)

                let statisticService = StatisticService()
                statisticService.updateTeamName(team: self.teams[indexPath.row], newName: newText)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension TeamsViewController {
    private func clearBackButtonTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: ""
        )
    }
}
