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

    private var teamModel = TeamModel()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        makeCell()
        configCell()
    }

    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
}

extension LeaderBoardCell {
    func makeCell() {
        contentView.addSubview(cellView)

        cellView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 12
            ),
            cellView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            cellView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -13
            ),
            cellView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            )
        ])
    }
}

extension LeaderBoardCell {
    func configCell() {
        let image = UIImageView()
        let name = UILabel()
        let points = UILabel()
        let pointsWord = UILabel()

        image.image = UIImage(named: teamModel.teamImage)
        name.text = teamModel.teamName
        points.text = "\(teamModel.teamScore)"
        pointsWord.text = teamModel.scoreWord

        name.font = UIFont.systemFont(
            ofSize: 20
        )
        points.font = UIFont.systemFont(
            ofSize: 60
        )
        pointsWord.font = UIFont.systemFont(
            ofSize: 15
        )

        cellView.addSubview(image)
        cellView.addSubview(name)
        cellView.addSubview(points)
        cellView.addSubview(pointsWord)

        image.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        points.translatesAutoresizingMaskIntoConstraints = false
        pointsWord.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(
                equalTo: cellView.centerYAnchor
            ),
            image.leadingAnchor.constraint(
                equalTo: cellView.leadingAnchor,
                constant: 15
            ),
            name.centerYAnchor.constraint(
                equalTo: cellView.centerYAnchor
            ),
            name.leadingAnchor.constraint(
                equalTo: image.trailingAnchor,
                constant: 34
            ),
            points.bottomAnchor.constraint(
                equalTo: pointsWord.topAnchor,
                constant: 10
            ),
            points.centerXAnchor.constraint(
                equalTo: pointsWord.centerXAnchor
            ),
            pointsWord.trailingAnchor.constraint(
                equalTo: cellView.trailingAnchor,
                constant: -18
            ),
            pointsWord.bottomAnchor.constraint(
                equalTo: cellView.bottomAnchor,
                constant: -14
            )
        ])
    }
}
