//
//  CategoriesFactory.swift
//  croco
//
//  Created by Ramil Yanberdin on 17.04.2023.
//

import UIKit

class CategoriesFactory {
    let categories: [CategoryModel] = [
        .init(categoryName: "Животные",
              image: UIImageView(
                image: UIImage(named: "animal")
              ),
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
              image: UIImageView(
                image: UIImage(named: "food")
              ),
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
              image: UIImageView(
                image: UIImage(named: "person")
              ),
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
              image: UIImageView(
                image: UIImage(named: "hobby")
              ),
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

    func getRandomWord(category: CategoryModel) -> String {
        category.items.randomElement() ?? "Items is empty"
    }
}
