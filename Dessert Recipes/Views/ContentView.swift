//
//  ContentView.swift
//  Dessert Recipes
//
//  Created by Bohdan Tkachenko on 11/20/23.
//

import SwiftUI

struct ContentView: View {
   @StateObject var mealFetcher = MealFetcher()
    
    var body: some View {

        MealListView(mealFetcher: mealFetcher)
        .onAppear {
            mealFetcher.fetchAllMeals()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
