//
//  TeamsView.swift
//  croco
//
//  Created by Евгений on 17.04.2023.
//

import UIKit

final class TeamsView {
    static let shared = TeamsView()
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        
        return imageView
    }()
    
    lazy var topTeamView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var topTeamImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Cowboy")
        
        return imageView
    }()
    
    lazy var topTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Ковбои"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var bottomTeamView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var bottomTeamImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Burger")
        
        return imageView
    }()
    
    lazy var bottomTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Стройняшки"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    var readyButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Игроки готовы", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "74A730")
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
}
