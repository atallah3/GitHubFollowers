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
    var filterdFollwers : [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var colllectionView : UICollectionView!
    var dataSourse : UICollectionViewDiffableDataSource<Section, Follower>!
    
//MARK: - View lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewDidLoad()
        configureSearchController()
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
                
                if self.followers.isEmpty{
                    let message = "This user doesn't have any followers. go follow them 😁"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                }
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate   = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
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
    
    
    func updateData(on followers : [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections ([.main])
        snapshot.appendItems (followers)
        DispatchQueue.main.async{
            self.dataSourse.apply(snapshot,animatingDifferences: true)
        }
    }
}

//MARK: - Extensions

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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filterdFollwers : followers
        let follower = activeArray[indexPath.item]
        
        let userInfoVC = UserInfoVC()
        userInfoVC.username = follower.login
        let navController = UINavigationController(rootViewController: userInfoVC)
        present(navController, animated: true)
    }
}


extension FollowersListVC : UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else {return}
        isSearching = true
        filterdFollwers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filterdFollwers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}
