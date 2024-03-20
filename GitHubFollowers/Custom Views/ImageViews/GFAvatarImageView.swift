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
    let cache = NetworkManager.shared.cache
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
    
    
    func downloadImage(for urlString : String) {
        let cachKey = NSString(string: urlString)
        if let image = cache.object(forKey: cachKey){
            self.image = image
        }
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            
            cache.setObject(image, forKey: cachKey)
            DispatchQueue.main.async {
                self.image = image
            }
        })
        task.resume()
    }
}
