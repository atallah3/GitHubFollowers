//
//  GFError.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 27/02/2024.
//

import Foundation

enum GFError : String, Error{
    case invalidUserame = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "This data recevied from the server was invalid. Please try again"
    case unableToFavorite = "Unable To Favoriting this user. Please try again"
    case alreadyInFavorite = "This user already in your favorites. You must really like him 😁"
}
