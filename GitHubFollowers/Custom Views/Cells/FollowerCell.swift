//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 10/02/2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    //MARK: - properties
    static let reuseId  = "followerCell"
    let avatarImageView = GFAvatarImageView(frame : .zero)
    let usernameLabelForImageView = GfTitleLabel(textAlignment: .center, fontSize: 16)
    
    //MARK: - initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    func set(follower : Follower) {
        usernameLabelForImageView.text = follower.login
        NetworkManager.shared.downloadImage(with: follower.avatarUrl) {[weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    
    private func configure(){
        addSubviews(avatarImageView,usernameLabelForImageView)
        
        let padding : CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabelForImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 25),
            usernameLabelForImageView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            usernameLabelForImageView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            usernameLabelForImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
