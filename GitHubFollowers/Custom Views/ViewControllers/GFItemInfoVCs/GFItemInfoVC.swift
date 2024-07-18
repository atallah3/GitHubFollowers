//
//  GFItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 01/03/2024.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    
    //MARK: - properties
    
    var stackView = UIStackView()
    var itemInfoOne = GFItemInfoView()
    var itemInfoTwo = GFItemInfoView()
    var actionButton = GFButton()
    
    var user : User!
    weak var delegate : UserInfoVCDelegate!
    //MARK: - init
    
    init(user : User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - viewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configurationActionButton()
        layoutUI()
        configureStackView()
    }
    
    
    private func configureBackgroundView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
    }
    
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(itemInfoOne)
        stackView.addArrangedSubview(itemInfoTwo)
    }
    
    
   private func configurationActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped(){}
    
    
    private func layoutUI() {
        view.addSubviews(stackView,actionButton)
        
        let padding : CGFloat = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
