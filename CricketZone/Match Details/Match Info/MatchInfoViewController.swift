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
    
    private var cancellables2: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        configureInfoCell()
        setupBinder()

    }
    
    func configureInfoCell(){
        let infoNib = UINib(nibName: Constants.infoTableViewCellId, bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: Constants.infoTableViewCellId)
    }
    
    
    func setupBinder() {
        MatchDetailsViewController.matchDetailsViewModel.$matchInfo.sink { [weak self] _ in

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }.store(in: &cancellables2)
    }
}

extension MatchInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
            return 1
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

    
}

extension MatchInfoViewController: UITableViewDelegate {
    
}
