//
//  TeamsViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class TeamsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackground()
        setTitle()
    }
    
    public func setBackground() {
        self.view.backgroundColor = .white
    }
    
    public func setTitle() {
        let label = UILabel()
        label.text = "Teams View Controller"
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
 
}
