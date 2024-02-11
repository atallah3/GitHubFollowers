//
//  ErrorMessaga.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 10/02/2024.
//

import Foundation

enum GFError : String, Error{
    case invalidUserame = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "This data recevied from the server was invalid. Please try again"
}
