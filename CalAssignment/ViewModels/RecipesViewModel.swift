//
//  RecipesViewModel.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import Foundation
import Combine

class RecipesViewModel: ObservableObject {
    @Published var recipes: RecipeResponse = []
    @Published var errorMessage: String? = nil
    
    init(mockRecipes: [Recipe]? = nil) {
        if let mockRecipes = mockRecipes {
            self.recipes = mockRecipes
        } else {
            loadRecipes()
        }
    }
    
    func loadRecipes() {
        NetworkService.shared.request(from: Constants.ApiConstants.recipesApiUrl) { [weak self] (result: Result<RecipeResponse, NetworkError>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(let recipes):
                        print("Fetched recipes successfully:")
                        self?.recipes = recipes
                    case .failure(let error):
                        print("Failed to fetch recipes: \(error)")
                        self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
