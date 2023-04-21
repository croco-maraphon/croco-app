//
//  LeaderBoardViewController.swift
//  croco
//
//  Created by Ramil Yanberdin on 18.04.2023.
//

import UIKit

final class LeaderBoardViewController: UIViewController {
    private var tableView: UITableView = {
        let tableView = UITableView()

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear

        return tableView
    }()

    private let restoreButton = UIButton()
    private var statisticService: StatisticService?
    private var leaderboard: [Team] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        statisticService = StatisticService()

        setBackground()
        setHeader()
        setTable()
        setRestoreButton()

        leaderboard = filterLeaderboard()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            LeaderBoardCell.self,
            forCellReuseIdentifier: LeaderBoardCell.reuseIdentifier
        )
    }

    @objc func restoreLeaderBoard() {
        self.tableView.removeFromSuperview()
        statisticService?.restoreLeaderboard()
    }
}

extension LeaderBoardViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return leaderboard.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: LeaderBoardCell.reuseIdentifier,
            for: indexPath
        )

        guard let leaderBoardCell = cell as? LeaderBoardCell else {
            return UITableViewCell()
        }
        leaderBoardCell.configCell(for: leaderboard[indexPath.row])

        return leaderBoardCell
    }
}

extension LeaderBoardViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        121
    }
}

extension LeaderBoardViewController {
    func setTable() {
        self.view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 40
            ),
            tableView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: -12
            ),
            tableView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: -124
            ),
            tableView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 12
            )
        ])
    }
}

extension LeaderBoardViewController {
    public func setBackground() {

        let imageView = UIImageView()
        imageView.image = UIImage(
            named: "background"
        )

        self.view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(
                equalTo: self.view.topAnchor
            ),
            imageView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor
            ),
            imageView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor
            ),
            imageView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor
            )
        ])
    }
}

extension LeaderBoardViewController {
    public func setHeader() {
        let label = UILabel()
        label.text = "Таблица лидеров"
        label.font = UIFont.systemFont(
            ofSize: 32,
            weight: .bold
        )

        navigationItem.titleView = label
    }
}

extension LeaderBoardViewController {
    private func setConfigurationToButton(
        button: UIButton,
        title: String,
        height: CGFloat
    ) {
        button.setTitle(title, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 20,
            weight: .regular
        )
        self.view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 14
            ),
            button.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: -14
            ),
            button.heightAnchor.constraint(
                equalToConstant: height
            ),
            button.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -27
            )
        ])
    }
}

extension LeaderBoardViewController {
    private func setRestoreButton() {
        setConfigurationToButton(
            button: restoreButton,
            title: "Сбросить",
            height: 63
        )

        restoreButton.backgroundColor = UIColor(
            red: 0.902,
            green: 0.275,
            blue: 0.275,
            alpha: 1
        )

        restoreButton.addTarget(
            self,
            action: #selector(restoreLeaderBoard),
            for: .touchUpInside
        )
    }
}

extension LeaderBoardViewController {
    func filterLeaderboard() -> [Team] {
        guard let statisticService = statisticService else {
            return []
        }
        return statisticService.getLeaderboard().sorted {
            $0.teamScore > $1.teamScore
        }
    }
}
