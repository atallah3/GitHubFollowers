//
//  GFRepoItemVC .swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 01/03/2024.
//

import UIKit

class GFRepoItemVC : GFItemInfoVC{

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    override func actionButtonTapped() {
        delegate.didTabGitHupProfileButton(for: user)
    }
    
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}

