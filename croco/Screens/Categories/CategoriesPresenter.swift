//
//  CategoriesPresenter.swift
//  croco
//
//  Created by Ramil Yanberdin on 17.04.2023.
//

import Foundation

final class CategoriesPresenter {
    public static var shared = CategoriesPresenter()

    public var categories: [CategoryModel] = []
    public var categoryViewModel = CategoryViewModel()

    var categoriesFactory: CategoriesFactory?


    public func getWordToPlay() -> String {
        guard let category = categories.randomElement() else {
            fatalError("CategoryFactory is empty")
        }

        categoriesFactory = CategoriesFactory()
        guard let categoriesFactory else {
            fatalError("categoriesFactory not found")
        }
        return categoriesFactory.getRandomWord(
            category: category
        )
    }

    func addCategory(category: CategoryModel) {
        CategoriesPresenter.shared.categories.append(category)
    }

    func removeCategory(category: CategoryModel) {
        CategoriesPresenter.shared.categories.removeAll { $0 == category }
    }

    func canStartGame() -> Bool {
        return !CategoriesPresenter.shared.categories.isEmpty
    }
}
