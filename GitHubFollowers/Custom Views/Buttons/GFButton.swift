//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 04/02/2024.
//

import UIKit

class GFButton: UIButton {
    
    //MARK: - initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(backgroundColor : UIColor,title : String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    //MARK: - Functions
    
    private func configure(){
        //this line to provide an custom constrains if it set to false
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 16
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        
    }
}
