//
//  HomeViewController.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var liveMatchCollectionView: UICollectionView!
    @IBOutlet weak var recentMatchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderView()
        
        liveMatchCollectionView.dataSource = self
        liveMatchCollectionView.delegate = self
        
        recentMatchTableView.dataSource = self
        recentMatchTableView.delegate = self
        
        configureLiveMatchCell()
        configureRecentMatchCell()

    }
    
    func configureHeaderView() {
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 20
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        headerView.dropShadow()
    }
    
    func configureLiveMatchCell(){
        let liveMatchCollectionCellNib = UINib(nibName: Constants.liveMatchCVCellId, bundle: nil)
        liveMatchCollectionView.register(liveMatchCollectionCellNib, forCellWithReuseIdentifier: Constants.liveMatchCVCellId)

        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.itemSize = CGSize(width: 400, height: 200)
        collectionViewCellLayout.scrollDirection = .horizontal
        liveMatchCollectionView.collectionViewLayout = collectionViewCellLayout
    }
    
    func configureRecentMatchCell(){
        let recentMatchNib = UINib(nibName: Constants.recentMatchTVCellId, bundle: nil)
        recentMatchTableView.register(recentMatchNib, forCellReuseIdentifier: Constants.recentMatchTVCellId)
    }


}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let liveMatchCollectionViewCell = liveMatchCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.liveMatchCVCellId, for: indexPath) as! LiveMatchCVCell
        
        return liveMatchCollectionViewCell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recentMatchCell = recentMatchTableView.dequeueReusableCell(withIdentifier: Constants.recentMatchTVCellId, for: indexPath) as! RecentMatchTVCell
        return recentMatchCell

    }
}

extension HomeViewController: UITableViewDelegate {
    
}



extension HomeViewController: UICollectionViewDelegateFlowLayout
{
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: headerView.frame.width - 50, height: 180)
           
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0
   }
}
