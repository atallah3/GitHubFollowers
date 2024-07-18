//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 12/02/2024.
//

import UIKit

// it was a struct and replace it eith enum because we don`t need any one to do that let helper = UIHelper()
enum UIHelper {
    
  static func createThreeColumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding : CGFloat = 12
        let itemMinimumSpace : CGFloat = 10
        let availableWidth = width - (itemMinimumSpace*2) - (padding*2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
            
        return flowLayout
    }
}
