//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 08/02/2024.
//

import Foundation


struct NetworkManager{
//    singleton
    static let shared = NetworkManager()
//    private init (){}
    
    let baseUrl = "https://api.github.com/users/"
    
    func getFollowers(For username : String,page : Int,completed : @escaping (Result<[Follower],GFError>)-> Void){
        let endPoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else{
            completed(.failure(.invalidUserame))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                    completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                    completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                    completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}