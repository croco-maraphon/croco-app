//
//  TeamModel.swift
//  croco
//
//  Created by Евгений on 18.04.2023.
//

import UIKit
import SnapKit

struct TeamModel {
    let name: UILabel
    let image: UIImage
    let scoreNumber: UILabel
    
    init(teamName: UILabel, teamLogo: UIImage, totalScore: UILabel) {
        self.name = teamName
        self.image = teamLogo
        self.scoreNumber = totalScore
    }
}
