//
//  RankViewController.swift
//  CricketZone
//
//  Created by Admin on 20/2/23.
//

import UIKit
import Combine

class RankViewController: UIViewController {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerBackground: UIView!
    private var cancellables: Set<AnyCancellable> = []
    
    let rankViewmodel = RankViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configureHeaderView()
        configureRankCell()
        configureRankHeader()
        
        rankViewmodel.fetchTeamRanking()
        setupBinder()

    }
    
    func configureHeaderView() {
        headerBackground.clipsToBounds = true
        headerBackground.layer.cornerRadius = 20
        headerBackground.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        headerBackground.dropShadow()
    }
    
    func configureRankHeader(){
        let headerNib = UINib(nibName: Constants.rankTableViewHeaderId, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.rankTableViewHeaderId)
    }
    
    func configureRankCell(){
        let teamNib = UINib(nibName: Constants.rankTableViewCellId, bundle: nil)
        tableView.register(teamNib, forCellReuseIdentifier: Constants.rankTableViewCellId)
    }
    
    func setupBinder() {
        rankViewmodel.$teamRankingList.sink { [weak self] teamRankingList in
            guard let self = self else {return}
            
            self.rankViewmodel.getCategoryWiseRankList(teamRankingList: teamRankingList, category: "ODI")
        }.store(in: &cancellables)
        
        rankViewmodel.$teamList.sink { [weak self] _ in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)

    }
    
    
    @IBAction func categorySegmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                self.rankViewmodel.getCategoryWiseRankList(teamRankingList: rankViewmodel.teamRankingList, category: "ODI")
            case 1:
                self.rankViewmodel.getCategoryWiseRankList(teamRankingList: rankViewmodel.teamRankingList, category: "TEST")
            case 2:
                self.rankViewmodel.getCategoryWiseRankList(teamRankingList: rankViewmodel.teamRankingList, category: "T20I")
            default:
                break
            }
    }
    
}

extension RankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(rankViewmodel.teamList?.count ?? 0)
        return rankViewmodel.teamList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rankCell = tableView.dequeueReusableCell(withIdentifier: Constants.rankTableViewCellId, for: indexPath) as? RankTableViewCell
        guard let rankCell = rankCell else {return UITableViewCell()}
        
        guard let teamList = rankViewmodel.teamList else {return UITableViewCell()}

        rankCell.rank.text = String(teamList[indexPath.row].ranking?.position ?? 0)
        rankCell.teamName.text = teamList[indexPath.row].name
        rankCell.teamImage.sd_setImage(
            with: URL(string: teamList[indexPath.row].image_path ?? ""),
            placeholderImage: UIImage(named: "f2")
        )
  
        rankCell.ratings.text = String(teamList[indexPath.row].ranking?.rating ?? 0)
        rankCell.points.text = String(teamList[indexPath.row].ranking?.points ?? 0)
        
        
        return rankCell
    }
    
    
    //Header
    
    //For tableView Section Header
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 0
            {
                let rankSectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.rankTableViewHeaderId) as? RankTableViewHeader
                return rankSectionHeader
            } else {
                return UIView()
            }
        }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}

extension RankViewController: UITableViewDelegate {
    
}
