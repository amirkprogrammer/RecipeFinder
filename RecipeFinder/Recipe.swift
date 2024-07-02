//
//  Recipe.swift
//  RecipeFinder
//
//  Created by Amir Kabiri on 6/30/24.
//

import Foundation
import Combine

class RecipeAPI: ObservableObject {
    @Published var recipes: [Recipe] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchRecipes(ingredients: [String], completion: @escaping ([Recipe]) -> Void) {
        let apiKey = "aae7c3c20ddd4d40a88840dbb072f53c"
        let baseUrl = "https://api.spoonacular.com/recipes/findByIngredients"
        let ingredientString = ingredients.joined(separator: ",")
        guard let url = URL(string: "\(baseUrl)?ingredients=\(ingredientString)&apiKey=\(apiKey)") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Recipe].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] recipes in
                self?.recipes = recipes
                completion(recipes)
            })
            .store(in: &cancellables)
    }
}

struct Recipe: Identifiable, Decodable {
    let id: Int
    let title: String
    let image: String
}
