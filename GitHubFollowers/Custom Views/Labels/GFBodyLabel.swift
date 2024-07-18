//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 07/02/2024.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    //MARK: - Functions
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        textColor = .secondaryLabel
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }
}
