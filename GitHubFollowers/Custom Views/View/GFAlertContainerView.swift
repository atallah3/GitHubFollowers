//
//  GFAlertContainerView.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 20/03/2024.
//

import UIKit

class GFAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        translatesAutoresizingMaskIntoConstraints = false
    }
}
