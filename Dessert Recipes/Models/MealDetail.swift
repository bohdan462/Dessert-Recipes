//
//  MealDetail.swift
//  Dessert Recipes
//
//  Created by Bohdan Tkachenko on 11/20/23.
//

import Foundation

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}

struct Ingredient: Decodable {
    let name: String
    let measurement: String
}

struct MealDetail: Decodable {
    let name: String
    let instructions: String
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case instructions = "strInstructions"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        var ingredients = [Ingredient]()
        for i in 1...20 {
            let ingredientKey = CodingKeys(rawValue: "strIngredient\(i)")
            let measurementKey = CodingKeys(rawValue: "strMeasure\(i)")
            
            if let ingredientKey = ingredientKey, let measurementKey = measurementKey,
            let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
            let measurement = try container.decodeIfPresent(String.self, forKey: measurementKey),
            !ingredient.isEmpty {
                let ingredientItem = Ingredient(name: ingredient, measurement: measurement)
                ingredients.append(ingredientItem)
            }
            
        }
        self.ingredients = ingredients
    }
}
