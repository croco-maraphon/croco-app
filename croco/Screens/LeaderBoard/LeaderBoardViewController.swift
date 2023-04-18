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

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackground()
        setHeader()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeaderBoardCell.self, forCellReuseIdentifier: LeaderBoardCell.reuseIdentifier)

        setTable()

        UserDefaults.standard.set(5, forKey: "croco Ковбои")
        let userDefaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
        let filter = userDefaultsDictionary.filter { (key, value) -> Bool in
            return key.hasPrefix("croco ")
        }
        print(filter.keys)
    }

    func setlabel() {
        let label = UILabel()
        label.text = "LeaderBoardViewController"
        self.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}

extension LeaderBoardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        leaderBoardCell.configCell()
        leaderBoardCell.backgroundColor = UIColor.clear
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
