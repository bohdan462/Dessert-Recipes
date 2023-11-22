//
//  APIService.swift
//  Dessert Recipes
//
//  Created by Bohdan Tkachenko on 11/20/23.
//

import Foundation

enum APIError: Error {
    case badURL
    case url(URLError?)
    case badResponse(statusCode: Int)
    case parsing(DecodingError?)
}

struct APIService {
    //MARK: - Method to fetch all meals
    func fetchMeals(completion: @escaping(Result<MealsResponse, APIError>) -> Void) {
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let meals = try decoder.decode(MealsResponse.self, from: data)
                    completion(Result.success(meals))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
            task.resume()
    }
    
    //MARK: - Method to fetch meal detail by id
    func fetchMealDetails(id: String, completion: @escaping(Result<MealDetailResponse, APIError>) -> Void) {
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let mealDetail = try decoder.decode(MealDetailResponse.self, from: data)
                    completion(Result.success(mealDetail))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
            task.resume()
    }
    
    static let exampleMeal = Meal(id: "53049", name: "Apam balik", image: "https:/www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
}
