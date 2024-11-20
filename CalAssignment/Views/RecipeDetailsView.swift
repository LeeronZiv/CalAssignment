//
//  RecipeDetailsView.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import SwiftUI

struct RecipeDetailsView: View {
    let encryptedRecipe: String?
    @State private var decryptedRecipe: Recipe?

    let encryptionService = BiometricEncryptionService()

    var body: some View {
        VStack {
            if let encryptedRecipe = encryptedRecipe {
                
                if decryptedRecipe == nil {
                    Button("Decrypt Recipe") {
                        decryptRecipe(encryptedRecipe)
                    }
                }

                if let recipe = decryptedRecipe {
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
            } else {
                Text("No data available.")
            }
        }
    }

    private func decryptRecipe(_ encryptedRecipe: String) {
        encryptionService.decryptWithBiometricAuthentication(encryptedRecipe, completion: { (decryptedRecipe: Recipe?) in
            if let recipe = decryptedRecipe {
                self.decryptedRecipe = recipe
            } else {
                print("Decryption failed.")
            }
        })
    }
}

#Preview {
   // RecipeDetailsView(recipe: MockData.recipes[0])
}
