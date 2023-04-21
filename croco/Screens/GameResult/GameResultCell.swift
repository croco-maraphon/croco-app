//
//  GameResultCell.swift
//  croco
//
//  Created by Евгений on 21.04.2023.
//

import UIKit

class GameResultCell: UITableViewCell {
    
    var team: Team? {
        didSet {
            guard let team = team else { return }
            
            let name = team.teamName
            teamLabel.text = name
            
            let image = team.teamImage
            teamAvatarLabel.text = image
            
            let score = String(team.teamScore)
            teamNumberLabel.text = score
        }
    }
    
    lazy var teamView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var teamAvatarLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 56)
        
        return label
    }()
    
    lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var teamNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        
        return label
    }()
    
    lazy var teamScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Очки"
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    override func layoutSubviews() {
        addView()
        setConstraints()
    }
    
    private func addView() {
        contentView.addSubview(teamView)
        teamView.addSubview(teamAvatarLabel)
        teamView.addSubview(teamLabel)
        teamView.addSubview(teamNumberLabel)
        teamView.addSubview(teamScoreLabel)
    }
    
    private func setConstraints() {
        teamView.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.leading.trailing.equalToSuperview().inset(10)
        }

        teamAvatarLabel.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(17)
        }

        teamLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        teamNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)

        }

        teamScoreLabel.snp.makeConstraints { make in
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
