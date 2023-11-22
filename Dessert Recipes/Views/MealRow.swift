//
//  MealRow.swift
//  Dessert Recipes
//
//  Created by Bohdan Tkachenko on 11/20/23.
//

import SwiftUI

struct MealRow: View {
    let meal: Meal
   private let imageSize: CGFloat = 100
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: meal.image)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(meal.name)
                    .font(.headline)
            }

        }
    }
}

struct MealRow_Previews: PreviewProvider {
    static var previews: some View {
        MealRow(meal: APIService.exampleMeal)
    }
}
