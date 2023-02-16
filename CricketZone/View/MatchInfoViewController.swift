//
//  MatchInfoViewController.swift
//  CricketZone
//
//  Created by BJIT on 2/13/23.
//

import UIKit
import Combine

class MatchInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        configureInfoCell()
        setupBinder()
        configurePreviousMatchCell()
        configureTeamFormHeader()
        tableView.sectionHeaderTopPadding = 0

    }
    

    func configureInfoCell(){
        let infoNib = UINib(nibName: Constants.infoTableViewCellId, bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: Constants.infoTableViewCellId)
    }
    
    func configurePreviousMatchCell(){
        let previousMatchNib = UINib(nibName: Constants.recentMatchTVCellId, bundle: nil)
        tableView.register(previousMatchNib, forCellReuseIdentifier: Constants.recentMatchTVCellId)
    }
    
    func configureTeamFormHeader(){
        let headerNib = UINib(nibName: Constants.teamFormHeaderId, bundle: nil)
        
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.teamFormHeaderId)
    }
    
    
    func setupBinder() {
        MatchDetailsViewController.matchDetailsViewModel.$matchInfo.sink { [weak self] _ in

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
    }
}

extension MatchInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            if MatchDetailsViewController.matchDetailsViewModel.matchDetails?.status == "NS" {
                return 0
            } else {
                return 1
            }
        } else if section == 2 {
            if MatchDetailsViewController.matchDetailsViewModel.matchDetails?.status == "Finished" {
                return 1
            } else {
                return 0
            }
        } else if section == 3 {
            if MatchDetailsViewController.matchDetailsViewModel.matchDetails?.status == "Finished" {
                return 1
            } else {
                return 0
            }
        } else if section == 5{
            return 0
        } else if section == 6 {
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let basicInfoCell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellId, for: indexPath) as? InfoTableViewCell
            guard let basicInfoCell = basicInfoCell else {return UITableViewCell()}
            
            basicInfoCell.headerLabel.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.league?.name
            basicInfoCell.subHeaderLabel.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.stage?.name
            basicInfoCell.label3.text = "Season: " + (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.season?.name ?? "")
            basicInfoCell.label4.text = "Round: " + (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.round ?? "")
            let dateTime = Shared().getReadableDateTime(data: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.starting_at ?? "")
            basicInfoCell.label5.text = "Time: " + dateTime.1 + ", " + dateTime.0
            basicInfoCell.CellImageView.sd_setImage(
                with: URL(string: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.league?.image_path ?? ""),
                placeholderImage: UIImage(named: "f1")
            )
            
            return basicInfoCell
        case 1:
            let tossResultCell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellId, for: indexPath) as? InfoTableViewCell
            guard let tossResultCell = tossResultCell else {return UITableViewCell()}
            tossResultCell.CellImageView.image = UIImage(named: "toss")
            tossResultCell.subHeaderLabel.text = (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.tosswon?.name ?? "") + " Won the Toss and Elected " + (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.elected ?? "")
            tossResultCell.headerLabel.text = ""
            tossResultCell.label3.text = ""
            tossResultCell.label4.text = ""
            tossResultCell.label5.text = ""
            return tossResultCell
        case 2:
            let matchResultCell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellId, for: indexPath) as? InfoTableViewCell
            guard let matchResultCell = matchResultCell else {return UITableViewCell()}
            matchResultCell.CellImageView.image = UIImage(named: "trophy")
            matchResultCell.subHeaderLabel.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.note
            matchResultCell.headerLabel.text = ""
            matchResultCell.label3.text = ""
            matchResultCell.label4.text = ""
            matchResultCell.label5.text = ""
            return matchResultCell
            
        //Man of the match
        case 3:
            let manOfMatchCell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellId, for: indexPath) as? InfoTableViewCell
            guard let manOfMatchCell = manOfMatchCell else {return UITableViewCell()}
            
            manOfMatchCell.headerLabel.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.manofmatch?.fullname
            manOfMatchCell.subHeaderLabel.text = "Man of the Match"
            manOfMatchCell.label3.text = "Position: " + (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.manofmatch?.position?.name ?? "")
            manOfMatchCell.label4.text = "Batting Style: " + (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.manofmatch?.battingstyle ?? "")
            manOfMatchCell.label5.text = "Bowling Style: " + (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.manofmatch?.bowlingstyle ?? "")
            manOfMatchCell.CellImageView.sd_setImage(
                with: URL(string: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.manofmatch?.image_path ?? ""),
                placeholderImage: UIImage(named: "f1")
            )
            return manOfMatchCell
            
        case 4:
            let venueCell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellId, for: indexPath) as? InfoTableViewCell
            guard let venueCell = venueCell else {return UITableViewCell()}
            venueCell.headerLabel.text = ""
            venueCell.subHeaderLabel.text = "Venue: " + (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.venue?.name ?? "")
            venueCell.label3.text = "City: " + (MatchDetailsViewController.matchDetailsViewModel.matchDetails?.venue?.city ?? "")
            venueCell.label4.text = "Capacity: " + String(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.venue?.capacity ?? 0)
            venueCell.label5.text = ""
            venueCell.CellImageView.sd_setImage(
                with: URL(string: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.venue?.image_path ?? ""),
                placeholderImage: UIImage(named: "f1")
            )

            
            return venueCell
        default:
            return UITableViewCell()
        }
    }
    
    
    //For tableView Section Header
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 5
            {
                let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.teamFormHeaderId) as! TeamFormTVHeaderFooterView
                
                
       
                
                var winrecords: [Bool] = Array(repeating: false, count: 5)
                for i in 0...4 {
                    if String(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam?.results?[i].winner_team_id ?? 0) == String(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam?.id ?? 0) {
                        winrecords[i] = true
                    } else {
                        winrecords[i] = false
                    }
                }
                sectionHeader.teamFormLabel.text = "Team 1 Form"
                
                sectionHeader.teamName.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.localteam?.name
                
                print(winrecords)
                for i in 0...4 {
                    if(winrecords[i] == true) {
                        let icon = sectionHeader.viewWithTag(i+1) as? UIImageView
                        icon?.image = UIImage(named: "Win")
                    } else {
                        let icon = sectionHeader.viewWithTag(i+1) as? UIImageView
                        icon?.image = UIImage(named: "Lost")
                    }
                }

                return sectionHeader
            }
            else if section == 6
            {
                let team2FormSectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.teamFormHeaderId) as! TeamFormTVHeaderFooterView
                
                var winrecords: [Bool] = Array(repeating: false, count: 5)
                for i in 0...4 {
                    if String(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam?.results?[i].winner_team_id ?? 0) == String(MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam?.id ?? 0) {
                        winrecords[i] = true
                    } else {
                        winrecords[i] = false
                    }
                }
                team2FormSectionHeader.teamFormLabel.text = "Team 2 Form"
                team2FormSectionHeader.teamName.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.visitorteam?.name
                
                print(winrecords)
                for i in 0...4 {
                    if(winrecords[i] == true) {
                        let icon = team2FormSectionHeader.viewWithTag(i+1) as? UIImageView
                        icon?.image = UIImage(named: "Win")
                    } else {
                        let icon = team2FormSectionHeader.viewWithTag(i+1) as? UIImageView
                        icon?.image = UIImage(named: "Lost")
                    }
                }

                return team2FormSectionHeader
            } else {
                return UIView()
            }
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if section == 5 {
                return 100
            } else if section == 6 {
                return 100
            } else {
                return 0
            }
        }
    
  
    
    

    
}

extension MatchInfoViewController: UITableViewDelegate {
    
}


