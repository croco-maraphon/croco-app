//
//  RoundResultsView.swift
//  croco
//
//  Created by Евгений on 18.04.2023.
//

import UIKit

final class RoundResultsView {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        
        return imageView
    }()
    
    // Top UI-block:
    
    lazy var topTeamView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var topTeamImageLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 56)
        
        return label
    }()
    
    lazy var topTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var topTeamNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60)
        
        return label
    }()
    
    lazy var topTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Очки"
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    // Mid UI-block:
    
    lazy var midImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var winOrLooseLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 28)
        
        return label
    }()
    
    lazy var getPointOrNotLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var pointsImage: UIImageView = {
        var imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var topScoreLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 60)
        
        return label
    }()
    
    lazy var bottomScoreLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    lazy var nextTurnLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    
    lazy var nextTurnButton: UIButton = {
        var button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "74A730")
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
}
