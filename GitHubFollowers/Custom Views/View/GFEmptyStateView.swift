//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 24/02/2024.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLabel = GfTitleLabel(textAlignment: .center, fontSize: 28)
    let emptyImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
   convenience init(message : String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(messageLabel,emptyImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        emptyImageView.image = Images.emptyStateLoge
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            emptyImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: 170),
            emptyImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
        
    }
}
