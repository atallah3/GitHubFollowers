//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 07/02/2024.
//

import UIKit

class FollowersListVC: UIViewController {
    //MARK: - Properties
    enum Section{
        case main
    }
    var userName : String!
    var followers : [Follower] = []
    var colllectionView : UICollectionView!
    var dataSourse : UICollectionViewDiffableDataSource<Section, Follower>!
    
    //MARK: - View lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewDidLoad()
        configureCollectionView()
        getFollowers()
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
    
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(For: userName, page: 1) { result in
            
            switch result {
            case .success(let followers):
                print("Succes!!!!!!!!!!!!!!!!!!!!")
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    func configureCollectionView() {
        colllectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(colllectionView)
        colllectionView.backgroundColor = .brown
        colllectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
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
