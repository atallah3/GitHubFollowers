//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 08/02/2024.
//

import UIKit


struct NetworkManager{
    //    singleton
    static let shared = NetworkManager()
    //    private init (){}
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString,UIImage>()
    
    func getFollowers(For username : String, page : Int, completed : @escaping (Result<[Follower],GFError>)-> Void){
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
    
    
    func getUserInfo(for username : String,completed : @escaping (Result<User,GFError>)->Void){
        let endPoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUserame))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error{
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(with urlString : String ,completed : @escaping (UIImage?) -> Void) {
        let cachKey = NSString(string: urlString)
        if let image = cache.object(forKey: cachKey){
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {  data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else{
                completed(nil)
                return
            }
            
            cache.setObject(image, forKey: cachKey)
           
            completed(image)
        })
        task.resume()
    }
}

