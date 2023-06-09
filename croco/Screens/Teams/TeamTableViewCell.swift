//
//  TeamTableViewCell.swift
//  croco
//
//  Created by Ilyas Tyumenev on 19.04.2023.
//

import UIKit
import SnapKit

class TeamTableViewCell: UITableViewCell {
    
    static let cellIdentifier = String(describing: UITableViewCell.self)

    var deleteCallback: ((_ indexPath: IndexPath) -> ())?
    var indexPath: IndexPath?
    
    var team: Team? {
        didSet {
            guard let teamItem = team else { return }

            let emoji = teamItem.teamImage
            profileLabel.text = emoji
            
            let name = teamItem.teamName
            nameLabel.text = "\(name)"
        }
    }
    
    private let cellBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 56)
        label.layer.cornerRadius = 28
        label.layer.masksToBounds = true
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let deleteTeamButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        addViews()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private Methods
    private func configureCell() {
        backgroundColor = .clear
    }
    
    private func addViews() {
        contentView.addSubview(cellBackgroundImageView)
        contentView.addSubview(profileLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(deleteTeamButton)
    }
    
    private func addConstraints() {
        cellBackgroundImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(96)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cellBackgroundImageView).inset(17)
            make.width.height.equalTo(56)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileLabel.snp.trailing).offset(34)
            make.trailing.equalTo(deleteTeamButton.snp.leading).inset(5)
        }
        
        deleteTeamButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(17)
            make.width.height.equalTo(62)
        }
        
        deleteTeamButton.addTarget(self, action: #selector(deleteTeam), for: .touchUpInside)
    }
    
    @objc func deleteTeam() {        
        if let indexPath = indexPath, let deleteCallback = deleteCallback {
            deleteCallback(indexPath)
        }
    }
}
