//
//  MealFetcher.swift
//  Dessert Recipes
//
//  Created by Bohdan Tkachenko on 11/20/23.
//

import Foundation

class MealFetcher: ObservableObject {
    @Published var meals: [Meal] = [Meal]()
    //MARK: - Pre cached property for Meal Details
    @Published var mealDetail: [String: MealDetail] = [:]
    
   private let service = APIService()
    
    func fetchAllMeals() {
        service.fetchMeals() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let mealsResponse):
                    self?.meals = mealsResponse.meals
                    
                    //MARK: Caching Meal Details
                    mealsResponse.meals.forEach { meal in
                        self?.fetchMealDetailWith(id: meal.id)
                    }
                }
            }
        }
    }
    
    //MARK: - Meal Detail Fetcher
    func fetchMealDetailWith(id: String) {
        if mealDetail[id] != nil {
            return
        }
        
        service.fetchMealDetails(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let mealsDetailResponse):
                    if let detail = mealsDetailResponse.meals.first {
                        self?.mealDetail[id] = detail
                    }
                }
            }
        }
    }
}

//MARK: - Mock Meal Fetcher
class MockMealFetcher: MealFetcher {
    override init() {
        super.init()
        self.meals = [
            Meal(id: "52977", name: "Cheesecake", image: "https://www.themealdb.com/images/media/meals/swttys1511385853.jpg"),
            Meal(id: "52978", name: "Apple Pie", image: "https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg")
        ]
    }
}
