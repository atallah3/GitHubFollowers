//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 14/03/2024.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    //MARK: - properties
    static let reuseId  = "favoriteCell"
    let avatarImageView = GFAvatarImageView(frame : .zero)
    let usernameLabelForImageView = GfTitleLabel(textAlignment: .left, fontSize: 26)
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    func set(favorite : Follower) {
        usernameLabelForImageView.text = favorite.login
        avatarImageView.downloadImage(for: favorite.avatarUrl)
    }
    
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabelForImageView)
        let padding : CGFloat = 12
        
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            usernameLabelForImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabelForImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 24),
            usernameLabelForImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: padding),
            usernameLabelForImageView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
    }
}
