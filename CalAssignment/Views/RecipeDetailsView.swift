//
//  RecipeDetailsView.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    let recipe: Recipe
    @State private var isAuthenticated = false
    @State private var showAuthenticationAlert = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if let imageUrl = URL(string: recipe.image) {
                        URLImage(url: imageUrl)
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .cornerRadius(4)
                    } else {
                        Image(systemName: "photo.fill")
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .cornerRadius(4)
                    }
                    
                    Text(recipe.name)
                        .font(.largeTitle)
                        .padding(.vertical)
                    
                    addLabelValueText(label: "Fats:", value: recipe.fats, font: .system(size: 16))
                    addLabelValueText(label: "Calories:", value: recipe.calories, font: .system(size: 16))
                    addLabelValueText(label: "Carbs:", value: recipe.carbos, font: .system(size: 16))

                    Text(recipe.description)
                        .padding(.top)
                }
                .padding()
            }
        }
    }
}

#Preview {
    RecipeDetailsView(recipe: MockData.recipes.first!)
}
