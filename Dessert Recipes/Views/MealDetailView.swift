//
//  MealDetailView.swift
//  Dessert Recipes
//
//  Created by Bohdan Tkachenko on 11/20/23.
//

import SwiftUI

struct MealDetailView: View {

    @ObservedObject var mealFetcher: MealFetcher
    
    let mealID: String
    
    var body: some View {
        if let mealDetail = mealFetcher.mealDetail[mealID] {
            ScrollView {
                VStack {
                    Text(mealDetail.name).font(.system(size: 24)).bold()
                        .padding(.bottom, 5)
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    ForEach(mealDetail.ingredients, id: \.name) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            Text(ingredient.measurement)
                        }.font(.footnote)
                    }
                }
                .padding()
                VStack(alignment: .leading, spacing: 5) {
                    Text("Instructions:").font(.headline)
                    Text(mealDetail.instructions).font(.footnote)
                    Spacer()
                }
            }
            .navigationTitle("Meal Details")
        } else {
            Text("Loading...")
        }
            
    }

}

