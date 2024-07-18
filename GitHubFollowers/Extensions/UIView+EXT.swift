//
//  UIView+EXT.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 26/03/2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views : UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
