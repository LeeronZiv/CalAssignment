//
//  MocData.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import Foundation

struct MockData {
    static let recipes: [Recipe] = [
        Recipe(
            id: "1",
            name: "Mozzarella and Pesto Roulades Mozzarella and Pesto Roulades ",
            thumb: "https://via.placeholder.com/50",
            headline: "Easy to make, perfect breakfast!",
            description: "A delicious recipe for pancakes, perfect for a breakfast treat.",
            image: "https://via.placeholder.com/200",
            difficulty: 2,
            calories: "250",
            carbos: "30g",
            fats: "10g",
            proteins: "5g"
        ),
        Recipe(
            id: "2",
            name: "Mock Salad",
            thumb: "https://via.placeholder.com/50",
            headline: "Healthy and fresh",
            description: "A fresh and healthy salad recipe with a variety of vegetables.",
            image: "https://via.placeholder.com/200",
            difficulty: 1,
            calories: "150",
            carbos: "20g",
            fats: "5g",
            proteins: "4g"
        ),
        Recipe(
            id: "3",
            name: "Mock Smoothie",
            thumb: "https://via.placeholder.com/50",
            headline: "Refreshing and energizing!",
            description: "A delicious smoothie packed with fruits and nutrients.",
            image: "https://via.placeholder.com/200",
            difficulty: 1,
            calories: "180",
            carbos: "35g",
            fats: "3g",
            proteins: "4g"
        )
    ]
}
