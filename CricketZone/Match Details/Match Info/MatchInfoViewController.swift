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
        MatchDetailsViewController.matchDetailsViewModel.$matchInfo.sink { [weak self] matchDetails in
            
            guard let matchDetails = matchDetails else {return}
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }.store(in: &cancellables2)
    }
}

extension MatchInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let basicInfoCell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellId, for: indexPath) as? InfoTableViewCell
            guard let basicInfoCell = basicInfoCell else {return UITableViewCell()}
            
            basicInfoCell.headerLabel.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.league?.name
            basicInfoCell.subHeaderLabel.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.stage?.name
            basicInfoCell.label3.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.season?.name
            basicInfoCell.label4.text = MatchDetailsViewController.matchDetailsViewModel.matchDetails?.round
            basicInfoCell.CellImageView.sd_setImage(
                with: URL(string: MatchDetailsViewController.matchDetailsViewModel.matchDetails?.league?.image_path ?? ""),
                placeholderImage: UIImage(named: "f1")
            )
            
            return basicInfoCell
        case 1:
            let sectionTwoCell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellId, for: indexPath) as? InfoTableViewCell
            guard let sectionTwoCell = sectionTwoCell else {return UITableViewCell()}
            // Configure the cell for section two
            return sectionTwoCell
        case 2:
            let sectionThreeCell = tableView.dequeueReusableCell(withIdentifier: Constants.infoTableViewCellId, for: indexPath) as? InfoTableViewCell
            guard let sectionThreeCell = sectionThreeCell else {return UITableViewCell()}
            // Configure the cell for section three
            return sectionThreeCell
        default:
            return UITableViewCell()
        }
    }

    
}

extension MatchInfoViewController: UITableViewDelegate {
    
}
