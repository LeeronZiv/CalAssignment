//
//  RecipesListView.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import SwiftUI

struct RecipesListView: View {
    @ObservedObject var viewModel: RecipesViewModel
    
    var body: some View {
        NavigationView {
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .padding()
            } else {
                List(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                        RecipeRowView(recipe: recipe)
                    }
                    .listRowSeparator(.hidden)
                }
                .navigationTitle("Recipes")
                .listStyle(PlainListStyle())
                
            }
        }
    }
}

#Preview {
    RecipesListView(viewModel: RecipesViewModel(mockRecipes: MockData.recipes))
}
