//
//  MockModel.swift
//  croco
//
//  Created by Ramil Yanberdin on 19.04.2023.
//

import UIKit

struct TeamModelMock {
    var name: String
    var points: Int
    let image: UIImage
    let pointsWord: String

    init() {
        name = "Ковбои"
        points = 8
        image = UIImage(named: "person") ?? UIImage()
        pointsWord = "Очки"
    }
}
