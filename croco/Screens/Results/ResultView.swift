//
//  ResultView.swift
//  croco
//
//  Created by Евгений on 17.04.2023.
//

import UIKit

final class ResultView {
    static let shared = ResultView()
    
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
    
    // Top UI-block:
    
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
    
    lazy var topTeamNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 40)
        
        return label
    }()
    
    lazy var topTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Очки"
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()

    // Middle UI- block:
    
    lazy var midTeamView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var midTeamImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Burger")
        
        return imageView
    }()
    
    lazy var midTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Стройняшки"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var midTeamNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.font = UIFont.systemFont(ofSize: 40)
        
        return label
    }()
    
    lazy var midTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Очки"
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    
    // Bottom UI - block
    
    lazy var bottomTeamView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var bottomTeamImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Cowboy")
        
        return imageView
    }()
    
    lazy var bottomTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Nails"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var bottomTeamNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = UIFont.systemFont(ofSize: 40)
        
        return label
    }()
    
    lazy var bottomTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Очки"
        label.font = UIFont.systemFont(ofSize: 15)
        
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
