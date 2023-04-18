//
//  ResultsViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class GameResultViewController: UIViewController {
    
    let resultView = GameResultView.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        
    }
}

extension GameResultViewController {
    private func setViews() {
        view.addSubview(resultView.backgroundImage)
        
        view.addSubview(resultView.resultLabel)
        
        resultView.topTeamView.addSubview(resultView.topTeamImage)
        resultView.topTeamView.addSubview(resultView.topTeamLabel)
        resultView.topTeamView.addSubview(resultView.topTeamNumberLabel)
        resultView.topTeamView.addSubview(resultView.topTeamScoreLabel)
        
        resultView.midTeamView.addSubview(resultView.midTeamImage)
        resultView.midTeamView.addSubview(resultView.midTeamLabel)
        resultView.midTeamView.addSubview(resultView.midTeamNumberLabel)
        resultView.midTeamView.addSubview(resultView.midTeamScoreLabel)
        
        resultView.bottomTeamView.addSubview(resultView.bottomTeamImage)
        resultView.bottomTeamView.addSubview(resultView.bottomTeamLabel)
        resultView.bottomTeamView.addSubview(resultView.bottomTeamNumberLabel)
        resultView.bottomTeamView.addSubview(resultView.bottomTeamScoreLabel)
        
        view.addSubview(resultView.topTeamView)
        view.addSubview(resultView.midTeamView)
        view.addSubview(resultView.bottomTeamView)
        view.addSubview(resultView.resetButton)
    }
    
    private func setConstraints() {
        resultView.backgroundImage.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        resultView.resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        // Top UI-block:
        resultView.topTeamView.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(resultView.resultLabel.snp.bottom).inset(-38)
        }
        
        resultView.topTeamImage.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(17)
        }
        
        resultView.topTeamLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        resultView.topTeamNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)

        }
        
        resultView.topTeamScoreLabel.snp.makeConstraints { make in
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        // Middle UI-block:
        resultView.midTeamView.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(resultView.topTeamView.snp.bottom).inset(-36)
        }
        
        resultView.midTeamImage.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(17)
        }
        
        resultView.midTeamLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        resultView.midTeamNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)

        }
        
        resultView.midTeamScoreLabel.snp.makeConstraints { make in
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        // Bottom UI-block:
        resultView.bottomTeamView.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(resultView.midTeamView.snp.bottom).inset(-36)
        }
        
        resultView.bottomTeamImage.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(17)
        }
        
        resultView.bottomTeamLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        resultView.bottomTeamNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)

        }
        
        resultView.bottomTeamScoreLabel.snp.makeConstraints { make in
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        resultView.resetButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(62)
        }
    }
}
