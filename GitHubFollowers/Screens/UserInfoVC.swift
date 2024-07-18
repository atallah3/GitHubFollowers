//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 26/02/2024.
//

import UIKit

protocol UserInfoVCDelegate : AnyObject {
    func didTabGitHupProfileButton(for user : User)
    func didTabGetFollowersButton(for user : User)
}

class UserInfoVC: GFDataLoadingVC {
    
//MARK: - properties
    
    var headerView = UIView()
    var itemViewOne = UIView()
    var itemViewTwo = UIView()
    var dataLabel = GFBodyLabel(textAlignment: .center)
    var itemViews : [UIView] = []
    
    var username : String!
    weak var delegate : FollowerListVCDelegate!
//MARK: - viewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
//MARK: - functions
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneBTN = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBTN
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else{return}
            
            switch result{
            case .success(let user):
                DispatchQueue.main.async {self.configurationUIElements(with: user)}
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
     
    func configurationUIElements(with user : User) {
        let RepoItemVC = GFRepoItemVC(user: user)
        RepoItemVC.delegate = self
        
        let followeItemVC = GFFollowerItemVC(user: user)
        followeItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: RepoItemVC, to: self.itemViewOne)
        self.add(childVC: followeItemVC, to: self.itemViewTwo)
        self.dataLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    func layoutUI() {
        itemViews = [headerView , itemViewOne , itemViewTwo,dataLabel]
        let padding : CGFloat = 20
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.layer.cornerRadius = 10
            itemView.backgroundColor = .systemBackground
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding)
            ])
        }
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dataLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dataLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func add(childVC : UIViewController,to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}


extension UserInfoVC : UserInfoVCDelegate{
    
    func didTabGitHupProfileButton(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invaild URL", message: "The URL attached to this user is invaild.", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }
    
    
    func didTabGetFollowersButton(for user: User) {
        
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user have no followers. go follow him", buttonTitle: "OK")
            return
        }
        
        delegate.didRequestFollowers(with: user.login)
        dismissVC()
    }
}
