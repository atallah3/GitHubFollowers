//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 01/03/2024.
//

import UIKit


class GFFollowerItemVC : GFItemInfoVC{

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    override func actionButtonTapped() {
        delegate.didTabGetFollowersButton(for: user)
    }
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
