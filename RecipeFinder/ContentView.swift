//
//  ContentView.swift
//  RecipeFinder
//
//  Created by Amir Kabiri on 6/30/24.
//
import SwiftUI

struct ContentView: View {
    @State private var ingredients: [String] = []
    @State private var newIngredient: String = ""
    @State private var recipes: [Recipe] = []
    @State private var navigateToRecipes = false
    @StateObject private var api = RecipeAPI()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter ingredient", text: $newIngredient)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .frame(height: 50)
                        .font(.title)
                    
                    Button {
                        if !newIngredient.isEmpty {
                            ingredients.append(newIngredient)
                            newIngredient = ""
                        }
                    } label: {
                        Text("Add")
                            .padding()
                            .frame(height: 50)
                            .font(.title)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                List {
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient)
                                .font(.title2)
                                .padding()
                            Spacer()
                        }
                        .background(Color.clear)
                        .cornerRadius(10)
                        .padding(.vertical, 5)
                        .listRowBackground(Color.clear) // Ensures the row background is clear
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(PlainListStyle()) // This removes the default list styling
                
                NavigationLink(destination: RecipeListView(recipes: recipes), isActive: $navigateToRecipes) {
                    EmptyView()
                }
                
                Button {
                    findRecipes()
                } label: {
                    Text("Find Recipes")
                        .padding()
                        .frame(height: 50)
                        .font(.title)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
                
            }
            .navigationTitle("Recipe Finder")
        }
    }
    
    func findRecipes() {
        api.fetchRecipes(ingredients: ingredients) { fetchedRecipes in
                    recipes = fetchedRecipes
                    navigateToRecipes = true
                }
            }
    
    func delete(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
