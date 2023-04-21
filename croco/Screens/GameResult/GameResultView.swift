//
//  ResultView.swift
//  croco
//
//  Created by Евгений on 17.04.2023.
//

import UIKit

final class GameResultView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        
        return imageView
    }()
        
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Результаты"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        
        return label
    }()
    
    lazy var resetButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Начать сначала", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "74A730")
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
}
