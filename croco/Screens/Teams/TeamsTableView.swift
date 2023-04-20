//
//  TeamsTableView.swift
//  croco
//
//  Created by Ilyas Tyumenev on 19.04.2023.
//

import UIKit
import SnapKit

class TeamsTableView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    let addTeamButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить команду", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#FA7800")
        button.layer.cornerRadius = 10
        return button
    }()
    
    let playersReadyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Игроки готовы", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#74A730")
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addViews() {
        addSubview(backgroundImageView)
        addSubview(tableView)
        addSubview(addTeamButton)
        addSubview(playersReadyButton)
    }
    
    private func addConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addTeamButton.snp.top).inset(18)
        }
        
        addTeamButton.snp.makeConstraints { make in
            make.bottom.equalTo(playersReadyButton.snp.top).offset(-18)
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(63)
        }
        
        playersReadyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(43)
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(63)
        }
    }
}
