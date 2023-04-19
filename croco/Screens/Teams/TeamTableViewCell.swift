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
    
    var team: Team? {
        didSet {
            guard let teamItem = team else {return}
            if let emoji = teamItem.emoji {
                profileImageView.image = emoji
            }
            
            if let name = teamItem.name {
                nameLabel.text = "\(name)"
            }
            
            if let result = teamItem.result {
                resultLabel.text = "\(result)"
            }
        }
    }
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 28
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        backgroundColor = .white
    }
    
    private func addViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(resultLabel)
    }
    
    private func addConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(56)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)            
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(20)
        }
    }
}
