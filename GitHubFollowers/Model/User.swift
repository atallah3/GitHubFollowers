//
//  User.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 08/02/2024.
//

import Foundation

struct User: Codable{
    let login : String
    let avatarUrl : String
    var name : String?
    var location : String?
    var bio : String?
    let htmlUrl : String
    let publicRepos : Int
    let publicGists : Int
    let followers : Int
    let following : Int
    let createdAt : String
}
