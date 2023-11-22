//
//  MealListView.swift
//  Dessert Recipes
//
//  Created by Bohdan Tkachenko on 11/20/23.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var mealFetcher: MealFetcher
    
    var body: some View {
            NavigationView {
                List(mealFetcher.meals, id: \.id) { meal in
                    NavigationLink(destination: MealDetailView(mealFetcher: mealFetcher, mealID: meal.id)) {
                        MealRow(meal: meal)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Desserts")
            }
        }
}


struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(mealFetcher: MockMealFetcher())
    }
}
