//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 10/02/2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    //MARK: - propertiews
    let AvatarPlaceHolder = UIImage(named: "avatar-placeholder")
        
    //MARK: - initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - functions
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = AvatarPlaceHolder
    }
}
