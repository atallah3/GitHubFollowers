//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 26/02/2024.
//

import UIKit

class UserInfoVC: UIViewController {
    
//MARK: - properties
    
    var username : String!
    
//MARK: - viewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneBTN = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBTN
        
        print(username!)
    }
    
//MARK: - functions
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

