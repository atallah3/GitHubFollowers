//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 04/02/2024.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK: - properties
    var logoImageView = UIImageView()
    
    var userNameTextField = GFTextField()
    
    var goToFollowersButtonAction = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    //MARK: - IBOutlet
    
    
    //MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurelogoImageView()
        configureUserNameTextField()
        configuregoToFollowersAction()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureUI()
        
    }
    
    //MARK: - Functions
    func configureUI(){
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    func configurelogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureUserNameTextField(){
        view.addSubview(userNameTextField)
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configuregoToFollowersAction(){
        view.addSubview(goToFollowersButtonAction)
        
        NSLayoutConstraint.activate([
            goToFollowersButtonAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            goToFollowersButtonAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            goToFollowersButtonAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            goToFollowersButtonAction.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    


}
