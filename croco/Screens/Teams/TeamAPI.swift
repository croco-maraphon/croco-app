//
//  TeamAPI.swift
//  croco
//
//  Created by Ilyas Tyumenev on 19.04.2023.
//

import Foundation
import UIKit

class TeamAPI {
    
    static func getEmoji() -> [String] {
        var emojies = [String]()
                
        while emojies.count < 4 {
            let randomElememnt = (0x1F300...0x1F3F0).randomElement()!
            guard let scalar = UnicodeScalar(randomElememnt) else { return ["❓", "❓"] }
            if !emojies.contains("\(scalar)") {
                emojies.append("\(scalar)")
            }
        }
        return emojies
    }
    
    static func getName() -> [String] {
        let names = [
            "Тигры", "Монстры", "Победители", "Зловещие", "Убийцы кроликов", "Мы-машина", "Непоколебимые",
            "Голодные звери", "Жаждущие крови", "Черная банда", "Безумные волки", "Дикие львы",
            "Монстры с клыками", "Древние зомби", "Машины-убийцы", "Мамонты", "Буйволы", "Беглые преступники",
            "Трансформеры", "Каменьщики", "Бездушные", "Фантастическая четверка", "Черепашки Ниндзя",
            "Халк и его команда", "Дубовые", "Гном-Гномычи", "Гиганты", "Гуливеры", "Беспощадные",
            "Большие и страшные", "Бандиты", "Без компромиссов", "Кладовщики", "Гробовщики", "Летающие воины",
            "Витязи", "Киборги", "Команда Кусто", "Пираты", "Беспредельщики", "Злые", "Безумные змеи", "Серые львы",
            "Стрелочники", "Оружейная банда", "Танкисты", "Громкие", "Молниеносцы", "Неробкие", "Подводники"
        ]
        
        var teamNames = [String]()
        
        while teamNames.count < 4 {
            guard let name = names.randomElement() else { return ["Команда 1", "Команда 2"] }
            if !teamNames.contains(name) {
                teamNames.append(name)
            }
        }
        return teamNames
    }
    
    static func getTeams() -> [Team] {
        let teamName = getName()
        let teamImage = getEmoji()
        
        let teams = [
            Team(teamName: teamName[0], teamImage: teamImage[0], teamScore: 0),
            Team(teamName: teamName[1], teamImage: teamImage[1], teamScore: 0)
        ]
        return teams
    }
    
    static func addTeam() -> [Team] {
        let teamName = getName()
        let teamImage = getEmoji()
        
        let newTeams = [
            Team(teamName: teamName[0], teamImage: teamImage[0], teamScore: 0),
            Team(teamName: teamName[1], teamImage: teamImage[1], teamScore: 0),
            Team(teamName: teamName[2], teamImage: teamImage[2], teamScore: 0),
            Team(teamName: teamName[3], teamImage: teamImage[3], teamScore: 0)            
        ]
        return newTeams
    }
}
