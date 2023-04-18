//
//  LeaderBoardCell.swift
//  croco
//
//  Created by Ramil Yanberdin on 18.04.2023.
//

import UIKit

final class LeaderBoardCell: UITableViewCell {
    static var reuseIdentifier = "LeaderBoardCell"

    private var cellView: UIView = {
        let view = UIView()

        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10

        return view
    }()
}

extension LeaderBoardCell {
    func configCell() {
        contentView.addSubview(cellView)

        cellView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 12),
            cellView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            cellView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -13
            ),
            cellView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            )
        ])
    }
}
