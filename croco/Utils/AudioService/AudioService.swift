//
//  AudioService.swift
//  croco
//
//  Created by Евгений on 20.04.2023.
//

import Foundation
import AVFoundation

enum Sounds: String {
    case counter
    case correctAnswer
    case wrongAnswer
    
    func getNameOfSound(_ sound: Sounds) -> String {
        switch sound {
        case .counter:
            return "Counter"
        case .correctAnswer:
            return "CorrectAnswer"
        case .wrongAnswer:
            return "WrongAnswer"
        }
    }
}

final class AudioService {
    
    static let shared = AudioService()
    
    var player: AVAudioPlayer?
    
    func makeSound(sound: Sounds) {
        let currentSound = sound.getNameOfSound(sound)
        guard let url = Bundle.main.url(forResource: currentSound, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error)
        }
    }
}
