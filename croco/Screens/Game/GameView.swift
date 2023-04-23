//
//  GameView.swift
//  croco
//
//  Created by Ilyas Tyumenev on 18.04.2023.
//

import UIKit
import SnapKit
import SwiftUI

class GameView: UIView {
    
    // MARK: - Private Properties
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let crocoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "crocoGame")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:60"
        label.font = UIFont.italicSystemFont(ofSize: 48)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    let currentTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let currentTeamImageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        
        return label
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "Картошка"
        label.font = UIFont.italicSystemFont(ofSize: 48)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = getAnExplanation()
        label.font = UIFont.italicSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        
        func getAnExplanation () -> String{
            let explanation = ["Объясни с помощью слов.",
                               "Объясни с помощью жестов.",
                               "Объясни с помощью рисунка.",
                               "Объясняй со злостью.",
                               "Объясняй с помощью мимики.",
                               "Объясняй вульгарно.",
                               "Объясняй сексуально."]
            return explanation[Int.random(in: 0..<explanation.count)]
        }
        return label
    }()
    
    let correctButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Правильно", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#74A730")
        button.layer.cornerRadius = 10
        return button
    }()
    
    let wrongButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нарушил правила", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#E64646")
        button.layer.cornerRadius = 10
        return button
    }()
    
    let mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сбросить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#8C9196")
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
        addSubview(crocoImageView)
        addSubview(timerLabel)
        addSubview(currentTeamLabel)
        addSubview(currentTeamImageLabel)
        addSubview(wordLabel)
        addSubview(commentLabel)
        addSubview(correctButton)
        addSubview(wrongButton)
        addSubview(mainButton)
    }
    
    private func addConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        crocoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(139)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(crocoImageView.snp.bottom).offset(57)
            make.centerX.equalToSuperview()
            make.width.equalTo(324)
            make.height.equalTo(37)
        }
        
        currentTeamLabel.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        currentTeamImageLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTeamLabel).offset(20)
            make.centerX.equalTo(currentTeamLabel)
        }
        
        wordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentTeamImageLabel).offset(60)
            make.width.equalTo(247)
            make.height.equalTo(48)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(wordLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(197)
            make.height.equalTo(48)
        }
        
        correctButton.snp.makeConstraints { make in
            make.bottom.equalTo(wrongButton.snp.top).offset(-11)
            make.centerX.equalToSuperview()
            make.width.equalTo(351)
            make.height.equalTo(60)
        }
        
        wrongButton.snp.makeConstraints { make in
            make.bottom.equalTo(mainButton.snp.top).offset(-11)
            make.centerX.equalToSuperview()
            make.width.equalTo(351)
            make.height.equalTo(60)
        }
        
        mainButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(351)
            make.height.equalTo(60)
        }
    }
}
