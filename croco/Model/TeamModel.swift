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
    let pointsWord: String
    
    init(teamName: UILabel, teamLogo: UIImage, totalScore: UILabel) {
        self.name = teamName
        self.image = teamLogo
        self.scoreNumber = totalScore
        pointsWord = "Очки"
    }
    
    init() {
        let name = UILabel()
        name.text =  "Ковбои"
        self.name = name
        
        let scoreNumber = UILabel()
        scoreNumber.text =  "0"
        self.scoreNumber = scoreNumber
        
        image = UIImage(named: "person") ?? UIImage()
        pointsWord = "Очки"
    }
}
