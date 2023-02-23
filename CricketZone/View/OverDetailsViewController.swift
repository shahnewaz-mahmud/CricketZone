//
//  OverDetailsViewController.swift
//  CricketZone
//
//  Created by Admin on 23/2/23.
//

import UIKit
import Combine

class OverDetailsViewController: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    
    let overDetailsViewModel = OverDetailsViewModel()
    
    
  
    @IBOutlet weak var teamSegment: UISegmentedControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configureOverInfoCell()
        setupBinder()
        
        

    }
    
    func configureOverInfoCell(){
        let overNib = UINib(nibName: Constants.overTableViewCellId, bundle: nil)
        tableView.register(overNib, forCellReuseIdentifier: Constants.overTableViewCellId)
    
    }
    
    func setupBinder() {
        
        MatchDetailsViewController.matchDetailsViewModel.$matchInfo.sink { [weak self] matchData in
            guard let self = self else {return}
            guard let matchData = matchData else {return}
            DispatchQueue.main.async {
                self.configureTeamSegment()
            }
        }.store(in: &cancellables)
        
        
        MatchDetailsViewController.matchDetailsViewModel.$overDetails.sink { [weak self] ballList in
            guard let self = self else {return}
            
            self.overDetailsViewModel.getOverList(teamId: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam_id ?? 0, balls:  ballList ?? [Ball]())
        }.store(in: &cancellables)
        
        overDetailsViewModel.$teamOverList.sink { [weak self] _ in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }    
            
        }.store(in: &cancellables)
    }
    
    
    func configureTeamSegment(){
        teamSegment.setTitle(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam?.name, forSegmentAt: 0)
        teamSegment.setTitle(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam?.name, forSegmentAt: 1)
    }
    
    
    
    @IBAction func teamSegmentControllerAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
            overDetailsViewModel.getOverList(teamId: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam_id ?? 0, balls: MatchDetailsViewController.matchDetailsViewModel.overDetails ?? [Ball]())
            case 1:
            overDetailsViewModel.getOverList(teamId: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam_id ?? 0, balls: MatchDetailsViewController.matchDetailsViewModel.overDetails ?? [Ball]())
            default:
                break
            }
    }
    
   
}
    



extension OverDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(overDetailsViewModel.teamOverList?.count ?? 0)
        return overDetailsViewModel.teamOverList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let overCell = tableView.dequeueReusableCell(withIdentifier: Constants.overTableViewCellId, for: indexPath) as? OverTableViewCell
        
        guard let overCell = overCell else {return UITableViewCell()}
        
        guard let overList = overDetailsViewModel.teamOverList else {return UITableViewCell()}
        
        overCell.overNum.text = "Over : " + String(indexPath.row + 1)
        
        let count = overList[indexPath.row]?.count
        
        guard let balls = overList[indexPath.row] else {return overCell}
        
        guard var count = count else {return overCell}
        
        if count > 10 {
            count = 10
        } else if count == 0 {
            return overCell
        }
        
        for i in 0...count - 1 {
            
            if(balls[i].score?.runs == 1 && balls[i].score?.ball == true ) {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "1")
            }  else if(balls[i].score?.is_wicket == true && balls[i].score?.out == true && balls[i].score?.ball == true)  {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "w")
            } else if(balls[i].score?.runs == 4)  {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "4")
            } else if(balls[i].score?.runs == 2)  {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "2")
            } else if(balls[i].score?.runs == 3)  {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "3")
            } else if(balls[i].score?.runs == 6)  {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "6")
            }  else if(balls[i].score?.leg_bye == 1)  {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "L")
            } else if(balls[i].score?.runs == 0 && balls[i].score?.ball == true)  {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "0")
            } else if(balls[i].score?.noball == 1)  {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "N")
            } else if(balls[i].score?.ball == false && balls[i].score?.name == "1 Wide"){
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "wd")
            } else {
                let icon = overCell.viewWithTag(i+1) as? UIImageView
                icon?.image = UIImage(named: "wd")
            }
        }
   
        for i in stride(from: 9, through: count, by: -1) {
            let icon = overCell.viewWithTag(i+1) as? UIImageView
            icon?.image = nil
        }
        
        return overCell
    }
}


extension OverDetailsViewController: UITableViewDelegate {
    
}
