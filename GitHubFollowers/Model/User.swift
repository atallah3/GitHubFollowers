//
//  User.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 08/02/2024.
//

import Foundation

struct User: Codable{
    var login : String
    var avatarUrl : String
    var name : String?
    var location : String?
    var bio : String?
    var htmlUrl : String
    var publicRepos : Int
    var publicGists : Int
    var followers : Int
    var following : Int
    var createdAt : String
}
