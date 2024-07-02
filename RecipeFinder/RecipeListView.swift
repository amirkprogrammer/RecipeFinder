//
//  RecipeListView.swift
//  RecipeFinder
//
//  Created by Amir Kabiri on 7/2/24.
//

import SwiftUI

struct RecipeListView: View {
    var recipes: [Recipe]
    
    var body: some View {
        List(recipes) { recipe in
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
                // add more details if you want. Calories, etc.
            }
            .padding()
        }
        .navigationTitle("Recipes")
    }
}

#Preview {
    RecipeListView(recipes: [Recipe(id: 1, title: "", image: "")])
}

