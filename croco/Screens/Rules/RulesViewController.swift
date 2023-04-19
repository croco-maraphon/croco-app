//
//  RulesViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import UIKit
import SwiftUI
import SnapKit



class RulesViewController: UIViewController {
    let textView = UITextView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setBackground()
            setupViews()
            setupConstraints()
        }
        
        func setupViews() {
            view.addSubview(textView)
            
            textView.text = "В игру играют командами из двух или более человек.\n\nЗадача каждого игрока команды - объяснить слово, которое он видит на экране, следуя условиям, которые дополнительно указаны под загаданным словом.\n\nЧем больше слов отгадала команда, тем больше она заработает баллов. \n\nВыигрывает команда, набравшая больше всего баллов. На отгадывание слова дается одна минуту.\n\nПри нарушении правил объяснения слова, ход передается следующей команде. \n\n... \n...\n"
            textView.font = UIFont.systemFont(ofSize: 21, weight: .regular)
            textView.textColor = .black
            textView.isEditable = false
            textView.isScrollEnabled = true
            textView.isSelectable = false
            textView.backgroundColor = .clear
        }
        
        func setupConstraints() {
            textView.snp.makeConstraints { (make) in
                make.edges.equalTo(view.safeAreaLayoutGuide).inset(8)
            }
        }
    public func setBackground() {
        let background = UIImage(named: "background")
        
        guard let background = background else {
            fatalError("background image is empty");
        }
        
        let imageView = UIImageView(image: background)
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view)
        }
    }
}

