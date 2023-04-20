//
//  TeamModel.swift
//  croco
//
//  Created by Евгений on 18.04.2023.
//

import UIKit
import SnapKit

struct TeamModel {
    var teamName: String
    let teamImage: String
    var teamScore: Int
    let scoreWord: String = "Очки"

    init(teamName: String, teamImage: String, teamScore: Int) {
        self.teamName = teamName
        self.teamImage = teamImage
        self.teamScore = teamScore
    }

    init() {
        teamName = "Ковбои"
        teamImage = "person"
        teamScore =  0
    }
}
