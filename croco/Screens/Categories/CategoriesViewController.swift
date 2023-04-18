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

    private var categoriesFactory: CategoriesFactory?
    private var presenter: CategoriesPresenter = CategoriesPresenter.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesFactory = CategoriesFactory()

        setBackground()
        setHeader()
        setButtons()
    }

    @objc func navigateToGame() {
        if presenter.canStartGame() {
            MainCoordinator.shared.push(.Game)
        }
    }

    @objc func animalButtonTapped() {
        guard let categoriesFactory else { return }

        if let checkBox = animalButton.viewWithTag(1) {
            checkBox.removeFromSuperview()

            presenter.removeCategory(
                category: categoriesFactory.categories[0]
            )
        } else {
            addCheckBox(to: animalButton)

            presenter.addCategory(
                category: categoriesFactory.categories[0]
            )
        }
    }

    @objc func foodButtonTapped() {
        guard let categoriesFactory else { return }

        if let checkBox = foodButton.viewWithTag(1) {
            checkBox.removeFromSuperview()

            presenter.removeCategory(
                category: categoriesFactory.categories[1]
            )
        } else {
            addCheckBox(to: foodButton)

            presenter.addCategory(
                category: categoriesFactory.categories[1]
            )
        }
    }

    @objc func personButtonTapped() {
        guard let categoriesFactory else { return }

        if let checkBox = personButton.viewWithTag(1) {
            checkBox.removeFromSuperview()

            presenter.removeCategory(
                category: categoriesFactory.categories[2]
            )
        } else {
            addCheckBox(to: personButton)

            presenter.addCategory(
                category: categoriesFactory.categories[2]
            )
        }
    }

    @objc func hobbyButtonTapped() {
        guard let categoriesFactory else { return }

        if let checkBox = hobbyButton.viewWithTag(1) {
            checkBox.removeFromSuperview()

            presenter.removeCategory(
                category: categoriesFactory.categories[3]
            )
        } else {
            addCheckBox(to: hobbyButton)

            presenter.addCategory(
                category: categoriesFactory.categories[3]
            )
        }
    }
}

extension CategoriesViewController {
    public func setBackground() {

        let imageView = UIImageView()
        imageView.image = UIImage(
            named: presenter.categoryViewModel.backgroundName
        )

        self.view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(
                equalTo: self.view.topAnchor
            ),
            imageView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor
            ),
            imageView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor
            ),
            imageView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor
            )
        ])
    }
}

extension CategoriesViewController {
    public func setHeader() {
        let label = UILabel()
        label.text = presenter.categoryViewModel.headerLabel
        label.font = UIFont.systemFont(
            ofSize: 32,
            weight: .bold
        )

        navigationItem.titleView = label
    }
}

extension CategoriesViewController {
    private func setConfigurationToButton(
        button: UIButton,
        title: String,
        height: CGFloat
    ) {
        button.setTitle(title, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 20,
            weight: .regular
        )
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
                equalToConstant: height
            )
        ])
    }
}

extension CategoriesViewController {
    private func setButtons() {
        guard let categoriesFactory else {
            return
        }
        setConfigurationToButton(
            button: animalButton,
            title: categoriesFactory.categories[0].categoryName,
            height: 96
        )
        setConfigurationToButton(
            button: foodButton,
            title: categoriesFactory.categories[1].categoryName,
            height: 96
        )
        setConfigurationToButton(
            button: personButton,
            title: categoriesFactory.categories[2].categoryName,
            height: 96
        )
        setConfigurationToButton(
            button: hobbyButton,
            title: categoriesFactory.categories[3].categoryName,
            height: 96
        )
        setConfigurationToButton(
            button: startGameButton,
            title: presenter.categoryViewModel.startGameButtonText,
            height: 63
        )

        animalButton.backgroundColor = UIColor(
            red: 0.688,
            green: 0.204,
            blue: 0.767,
            alpha: 1
        )
        foodButton.backgroundColor = UIColor(
            red: 0.779,
            green: 0.833,
            blue: 0.156,
            alpha: 1
        )
        personButton.backgroundColor = UIColor(
            red: 0.141,
            green: 0.534,
            blue: 0.846,
            alpha: 1
        )
        hobbyButton.backgroundColor = UIColor(
            red: 0.902,
            green: 0.275,
            blue: 0.275,
            alpha: 1
        )
        startGameButton.backgroundColor = UIColor(
            red: 0.455,
            green: 0.655,
            blue: 0.188,
            alpha: 1
        )

        animalButton.addTarget(
            self,
            action: #selector(animalButtonTapped),
            for: .touchUpInside
        )
        foodButton.addTarget(
            self,
            action: #selector(foodButtonTapped),
            for: .touchUpInside
        )
        personButton.addTarget(
            self,
            action: #selector(personButtonTapped),
            for: .touchUpInside
        )
        hobbyButton.addTarget(
            self,
            action: #selector(hobbyButtonTapped),
            for: .touchUpInside
        )
        startGameButton.addTarget(
            self,
            action: #selector(navigateToGame),
            for: .touchUpInside
        )

        addCategoryButtonsSubview()
    }
}

extension CategoriesViewController {
    private func addCategoryButtonsSubview() {
        guard let categoriesFactory else { return }
        self.view.addSubview(animalButton)
        animalButton.addSubview(
            categoriesFactory.categories[0].image
        )

        self.view.addSubview(foodButton)
        foodButton.addSubview(
            categoriesFactory.categories[1].image
        )

        self.view.addSubview(personButton)
        personButton.addSubview(
            categoriesFactory.categories[2].image
        )

        self.view.addSubview(hobbyButton)
        hobbyButton.addSubview(
            categoriesFactory.categories[3].image
        )

        applyConstraintsToButtons()
    }

    private func applyConstraintsToButtons() {
        guard let categoriesFactory else { return }
        NSLayoutConstraint.activate([
            animalButton.topAnchor.constraint(
                equalTo: self.view.topAnchor,
                constant: 180),
            foodButton.topAnchor.constraint(
                equalTo: animalButton.bottomAnchor,
                constant: 25),
            personButton.topAnchor.constraint(
                equalTo: foodButton.bottomAnchor,
                constant: 25),
            hobbyButton.topAnchor.constraint(
                equalTo: personButton.bottomAnchor,
                constant: 25),
            startGameButton.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -27
            )
        ])

        applyConstraintsToImageViewInButton(
            for: categoriesFactory.categories[0].image,
            to: animalButton
        )
        applyConstraintsToImageViewInButton(
            for: categoriesFactory.categories[1].image,
            to: foodButton
        )
        applyConstraintsToImageViewInButton(
            for: categoriesFactory.categories[2].image,
            to: personButton
        )
        applyConstraintsToImageViewInButton(
            for: categoriesFactory.categories[3].image,
            to: hobbyButton
        )
    }

    private func applyConstraintsToImageViewInButton(
        for image: UIImageView,
        to button: UIButton
    ) {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(
                equalToConstant: 56
            ),
            image.widthAnchor.constraint(
                equalToConstant: 56
            ),
            image.centerYAnchor.constraint(
                equalTo: button.centerYAnchor
            ),
            image.leadingAnchor.constraint(
                equalTo: button.leadingAnchor,
                constant: 19
            )
        ])
    }
}

extension CategoriesViewController {
    private func addCheckBox(to button: UIButton) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkBox")
        imageView.tag = 1

        button.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor,
                                               constant: -20),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
}
