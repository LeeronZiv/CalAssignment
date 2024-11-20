//
//  RecipesDataSource.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import Foundation

typealias RecipeResponse = [Recipe]

struct Recipe: Codable, Identifiable {
    let id: String
    let name: String
    let thumb: String
    let headline: String
    let description: String
    let image: String
    let difficulty: Int
    let calories: String
    let carbos: String
    let fats: String
    let proteins: String
}
