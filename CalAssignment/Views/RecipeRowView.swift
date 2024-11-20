//
//  RecipeRowView.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 10) {
            if let imageUrl = URL(string: recipe.thumb) {
                URLImage(url: imageUrl)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
            } else {
                Image(systemName: "photo.fill")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                HStack(spacing: 10) {
                    addLabelValueText(label: "Fats:", value: recipe.fats)
                    addLabelValueText(label: "Calories:", value: recipe.calories)
                    addLabelValueText(label: "Carbs:", value: recipe.carbos)
                }
                .lineLimit(1)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 0)
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRowView(recipe: MockData.recipes.first!)
    }
}
