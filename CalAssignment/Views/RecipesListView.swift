//
//  RecipesListView.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//
import SwiftUI

struct RecipesListView: View {
    @ObservedObject var viewModel: RecipesViewModel
    @State private var encryptedRecipe: String?
    @State private var navigateToDetails = false
    private let encryptionService = BiometricEncryptionService()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    Text("Loading...")
                    ProgressView()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .padding()
                } else {
                    List(viewModel.recipes) { recipe in
                        Button(action: {
                            encryptRecipe(recipe)
                        }) {
                            RecipeRowView(recipe: recipe)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .navigationTitle("Recipes")
                    .listStyle(PlainListStyle())
                    
                    // Navigate to RecipeDetailsView when encryption is complete
                    .navigationDestination(isPresented: $navigateToDetails) {
                        if let encryptedRecipe = encryptedRecipe {
                            RecipeDetailsView(encryptedRecipe: encryptedRecipe)
                        }
                    }
                }
            }
        }
    }
    
    private func encryptRecipe(_ recipe: Recipe) {
        encryptionService.encryptWithBiometricAuthentication(recipe) { encryptedData in
            if let encryptedData = encryptedData {
                self.encryptedRecipe = encryptedData
                self.navigateToDetails = true
            } else {
                print("Encryption failed.")
            }
        }
    }
}

#Preview {
    RecipesListView(viewModel: RecipesViewModel(mockRecipes: MockData.recipes))
}
