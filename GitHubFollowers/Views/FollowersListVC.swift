//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 07/02/2024.
//

import UIKit

class FollowersListVC: UIViewController {
    //MARK: - Properties
    enum Section{ case main }
    
    var username : String!
    var followers : [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var colllectionView : UICollectionView!
    var dataSourse : UICollectionViewDiffableDataSource<Section, Follower>!
    
    //MARK: - View lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewDidLoad()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK: - Functions
    
    func configureViewDidLoad() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func getFollowers(username : String,page : Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(For: username, page: page) { [weak self]  result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100{
                    hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    func configureCollectionView() {
        colllectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        colllectionView.delegate = self
        view.addSubview(colllectionView)
        colllectionView.backgroundColor = .systemBackground
        colllectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    
    func configureDataSource() {
        dataSourse = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: colllectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
            
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections ([.main])
        snapshot.appendItems (followers)
        DispatchQueue.main.async{
            self.dataSourse.apply(snapshot,animatingDifferences: true)
        }
    }
}


extension FollowersListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height{
            guard hasMoreFollowers else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
