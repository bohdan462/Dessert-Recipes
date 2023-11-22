//
//  APIService.swift
//  Dessert Recipes
//
//  Created by Bohdan Tkachenko on 11/20/23.
//

import Foundation

enum APIError: Error {
    /// Indicates that the URL is invalid
    case badURL
    ///Indicates an error related to the URL
    case url(URLError?)
    ///Indicates a bad response status code. The HTTP response code recived in the response
    case badResponse(statusCode: Int)
    ///Indicates a parsing error while decoding data
    case parsing(DecodingError?)
}

struct APIService {
    //MARK: - Method to fetch all meals
    ///Parameter completion: A closure to handle a result
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
    ///Parameter id: The id of the meal to fetch
    ///Parameters completion: a closure to handle a result
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
    
    ///An example meal used for referance
    static let exampleMeal = Meal(id: "53049", name: "Apam balik", image: "https:/www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
}
