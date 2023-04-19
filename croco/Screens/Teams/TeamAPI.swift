//
//  TeamAPI.swift
//  croco
//
//  Created by Ilyas Tyumenev on 19.04.2023.
//

import Foundation
import UIKit

class TeamAPI {
    
    static func getTeam() -> [Team]{
        let teams = [
            Team(name: "Ковбои", emoji: UIImage(named: "Cowboy"), result: "20"),
            Team(name: "Стройняшки", emoji: UIImage(named: "Burger"), result: "15"),
            Team(name: "Красотки", emoji: UIImage(named: "Nails"), result: "10")
        ]
        return teams
    }
}
