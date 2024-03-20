//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 05/03/2024.
//

import UIKit

enum presistenceActionType {
    case add,remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum keys {
        static let favorite = "favorite"
    }
    
    
    static func updateWith(favorite : Follower ,actionType : presistenceActionType,completed : @escaping (GFError?)->Void){
        retrieveFollowers { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorite = favorites
                switch actionType{
                case .add:
                    guard !retrievedFavorite.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }
                    retrievedFavorite.append(favorite)
                case .remove:
                    retrievedFavorite.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorites: retrievedFavorite))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFollowers(completed: @escaping (Result<[Follower],GFError>)-> Void ){
        guard let favoriteData = defaults.object(forKey: keys.favorite) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoriteData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    
    static func save(favorites : [Follower]) -> GFError? {
        do{
            let encoder = JSONEncoder()
            let favorite = try encoder.encode(favorites)
            defaults.set(favorite, forKey: keys.favorite)
            return nil
        }catch{
            return .unableToFavorite
        }
    }
}
