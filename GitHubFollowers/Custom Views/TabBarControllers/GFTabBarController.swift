//
//  GFTabBarController.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 17/03/2024.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(),createFavoriteNC()]
    }
    
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavoriteNC() -> UINavigationController {
        let facoriteVC = FavoriteListVC()
        facoriteVC.title = "Favorite"
        facoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: facoriteVC)
    }
}
