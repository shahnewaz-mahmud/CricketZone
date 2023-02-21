//
//  HomeViewController.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var liveMatchCollectionView: UICollectionView!
    @IBOutlet weak var recentMatchTableView: UITableView!
    @IBOutlet weak var liveMatchCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerSectionHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var recentMatchTopSpaceConstraint: NSLayoutConstraint!
    
    var homeViewModel = HomeViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderView()
        
        liveMatchCollectionView.dataSource = self
        liveMatchCollectionView.delegate = self
        
        recentMatchTableView.dataSource = self
        recentMatchTableView.delegate = self
        
        
        configureLiveMatchCell()
        configureRecentMatchCell()
        configureRecentMatchHeader()
        
        homeViewModel.fetchLiveMatch()
        homeViewModel.fetchRecentMatch()
        homeViewModel.fetchAllPlayers()
        homeViewModel.fetchAllSeasons()
        
        setupBinder()
        
        testMethod()

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
    func configureRecentMatchHeader(){
        let headerNib = UINib(nibName: Constants.playerTeamUITableViewHeaderViewId, bundle: nil)
        recentMatchTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.playerTeamUITableViewHeaderViewId)
    }
    
    func setupBinder() {
        homeViewModel.$liveMatchList.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.liveMatchCollectionView.reloadData()
            }
            
        }.store(in: &cancellables)
        
        homeViewModel.$recentMatchList.sink{ [weak self] _ in
            DispatchQueue.main.async {
                print("Hello")
                self?.recentMatchTableView.reloadData()
            }
            
        }.store(in: &cancellables)
    }
    
    func testMethod() {
        
    }


}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.liveMatchList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let liveMatchCollectionViewCell = liveMatchCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.liveMatchCVCellId, for: indexPath) as? LiveMatchCVCell
        
        guard let liveMatchCollectionViewCell = liveMatchCollectionViewCell else { return UICollectionViewCell() }

        guard let liveMatchList = homeViewModel.liveMatchList else { return UICollectionViewCell() }

        liveMatchCollectionViewCell.setMatch(matchInfo: liveMatchList[indexPath.row])
        
        return liveMatchCollectionViewCell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let liveMatchList = homeViewModel.liveMatchList else { return }
        
        if liveMatchList[indexPath.row].status != "NS" {
            homeViewModel.goToMatchDetailsPage(matchId: liveMatchList[indexPath.row].id ?? 123, isLive: true, originVC: self)
        } else {
            homeViewModel.goToMatchDetailsPage(matchId: liveMatchList[indexPath.row].id ?? 123, isLive: false, originVC: self)
        }
        
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.recentMatchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recentMatchCell = recentMatchTableView.dequeueReusableCell(withIdentifier: Constants.recentMatchTVCellId, for: indexPath) as? RecentMatchTVCell
        
        guard let recentMatchCell = recentMatchCell else { return UITableViewCell() }

        guard let recentMatchList = homeViewModel.recentMatchList else { return UITableViewCell() }

        recentMatchCell.setMatch(matchInfo: recentMatchList[indexPath.row])
        
        return recentMatchCell

    }
    
    //Header
    
    //For tableView Section Header
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 0
            {
                let currentTeamHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.playerTeamUITableViewHeaderViewId) as! PlayerTeamUITableViewHeaderView
                currentTeamHeader.headerLabel.text = "Recent Matches"
                return currentTeamHeader
            } else {
                return UIView()
            }
        }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recentMatchCell = homeViewModel.recentMatchList else { return }
        
        homeViewModel.goToMatchDetailsPage(matchId: recentMatchCell[indexPath.row].id ?? 123, isLive: false, originVC: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 100 {
                self.view.layoutIfNeeded() // <-- Call layoutIfNeeded() first
                
            UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
                    guard let self = self else {return}
                    self.liveMatchCollectionView.isHidden = true
                    self.headerSectionHeightConstraint.constant = 140
                    self.recentMatchTopSpaceConstraint.constant = 10
                    
                    self.view.layoutIfNeeded() // <-- Call layoutIfNeeded() again inside the animation block
                })
            } else {
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
                    guard let self = self else {return}
                    
                    self.headerSectionHeightConstraint.constant = 150
                    self.recentMatchTopSpaceConstraint.constant = 135
                    self.liveMatchCollectionView.isHidden = false
                    self.view.layoutIfNeeded()
                })
                
                
            }
    }
    
    
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
