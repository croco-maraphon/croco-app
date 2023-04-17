//
//  CategoriesViewController.swift
//  croco
//
//  Created by Aleksandr Menshikov on 17.04.2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class CategoriesViewController: UIViewController {

    public let categories: [CategoryModel] = [
        .init(categoryName: "Животные",
              image: UIImageView(image: UIImage(named: "animal")),
              items: ["Крокодил",
                      "Жираф",
                      "Лев",
                      "Пингвин",
                      "Медведь",
                      "Слон",
                      "Обезьяна",
                      "Змея",
                      "Лиса",
                      "Бегемот"]
             ),
        .init(categoryName: "Еда",
              image: UIImageView(image: UIImage(named: "food")),
              items: ["Гамбургер",
                      "Пицца",
                      "Суши",
                      "Салат",
                      "Суп",
                      "Чипсы",
                      "Блины",
                      "Сэндвич",
                      "Паста",
                      "Кекс"]
             ),
        .init(categoryName: "Личности",
              image: UIImageView(image: UIImage(named: "person")),
              items: ["Альберт Эйнштейн",
                      "Майкл Джексон",
                      "Мэрилин Монро",
                      "Барбара Стрейзанд",
                      "Стив Джобс",
                      "Шекспир",
                      "Чарли Чаплин",
                      "Опра Уинфри",
                      "Мадонна",
                      "Том Круз"]
             ),
        .init(categoryName: "Хобби",
              image: UIImageView(image: UIImage(named: "hobby")),
              items: ["Рисование",
                      "Кулинария",
                      "Шитье",
                      "Садоводство",
                      "Фотография",
                      "Музыка",
                      "Плавание",
                      "Футбол",
                      "Гольф",
                      "Шахматы"]
             )
    ]

    private var animalButton: UIButton = {
        return UIButton()
    }()

    private var foodButton: UIButton = {
        return UIButton()
    }()

    private var personButton: UIButton = {
        return UIButton()
    }()

    private var hobbyButton: UIButton = {
        return UIButton()
    }()

    private var startGameButton: UIButton = {
        return UIButton()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackground(named: "background")
        setHeader(text: "Категории")

        setStartGameButton()


        setCategoryButtons()
        addCategoryButtonsSubview()



    }

    @objc func navigateToGame() {
        MainCoordinator.shared.push(.Game)
    }
}

extension CategoriesViewController {
    public func setBackground(named: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)

        self.view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
}

extension CategoriesViewController {
    public func setHeader(text: String) {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)

        navigationItem.titleView = label
    }
}

extension CategoriesViewController {
    private func setStartGameButton() {
        startGameButton.setTitle("Начать игру", for: .normal)
        startGameButton.layer.masksToBounds = true
        startGameButton.layer.cornerRadius = 10
        startGameButton.backgroundColor = UIColor(red: 0.455, green: 0.655, blue: 0.188, alpha: 1)
        startGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        startGameButton.addTarget(self, action: #selector(navigateToGame), for: .touchUpInside)

        self.view.addSubview(startGameButton)

        startGameButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            startGameButton.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 14
            ),
            startGameButton.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: -14
            ),
            startGameButton.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -27
            ),
            startGameButton.heightAnchor.constraint(
                equalToConstant: 63
            )
        ])

    }
}

extension CategoriesViewController {
    private func setConfigurationToButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        self.view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 14
            ),
            button.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: -14
            ),
            button.heightAnchor.constraint(
                equalToConstant: 96
            )
        ])
    }
}

extension CategoriesViewController {
    private func setCategoryButtons() {
        setConfigurationToButton(
            button: animalButton,
            title: categories[0].categoryName
        )
        setConfigurationToButton(
            button: foodButton,
            title: categories[1].categoryName
        )
        setConfigurationToButton(
            button: personButton,
            title: categories[2].categoryName
        )
        setConfigurationToButton(
            button: hobbyButton,
            title: categories[3].categoryName
        )
        animalButton.backgroundColor = UIColor(red: 0.688, green: 0.204, blue: 0.767, alpha: 1)
        foodButton.backgroundColor = UIColor(red: 0.779, green: 0.833, blue: 0.156, alpha: 1)
        personButton.backgroundColor = UIColor(red: 0.141, green: 0.534, blue: 0.846, alpha: 1)
        hobbyButton.backgroundColor = UIColor(red: 0.902, green: 0.275, blue: 0.275, alpha: 1)
    }
}

extension CategoriesViewController {
    private func addCategoryButtonsSubview() {
        self.view.addSubview(animalButton)
        animalButton.addSubview(categories[0].image)
        self.view.addSubview(foodButton)
        foodButton.addSubview(categories[1].image)
        self.view.addSubview(personButton)
        personButton.addSubview(categories[2].image)
        self.view.addSubview(hobbyButton)
        hobbyButton.addSubview(categories[3].image)

        applyConstraintsToCategoryButtons()
    }

    private func applyConstraintsToCategoryButtons() {
        NSLayoutConstraint.activate([
            animalButton.topAnchor.constraint(equalTo: self.view.topAnchor,
                                             constant: 180),
            foodButton.topAnchor.constraint(equalTo: animalButton.bottomAnchor,
                                           constant: 25),
            personButton.topAnchor.constraint(equalTo: foodButton.bottomAnchor,
                                             constant: 25),
            hobbyButton.topAnchor.constraint(equalTo: personButton.bottomAnchor,
                                            constant: 25)
        ])

        applyConstraintsToImageViewInButton(for: categories[0].image, to: animalButton)
        applyConstraintsToImageViewInButton(for: categories[1].image, to: foodButton)
        applyConstraintsToImageViewInButton(for: categories[2].image, to: personButton)
        applyConstraintsToImageViewInButton(for: categories[3].image, to: hobbyButton)
    }

    private func applyConstraintsToImageViewInButton(for image: UIImageView, to button: UIButton) {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 56),
            image.widthAnchor.constraint(equalToConstant: 56),
            image.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: button.leadingAnchor,
                                                        constant: 19)
        ])
    }
}
