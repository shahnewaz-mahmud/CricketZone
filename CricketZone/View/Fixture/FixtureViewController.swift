//
//  FixtureViewController.swift
//  CricketZone
//
//  Created by BJIT on 2/9/23.
//

import UIKit
import Combine

class FixtureViewController: UIViewController {
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    @IBOutlet weak var leagueCollectionView: UICollectionView!
    
    @IBOutlet weak var headerBackground: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let fixtureViewModel = FixtureViewModel()
 
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderView()
        
        calendarCollectionView.tag = 0
        leagueCollectionView.tag = 1
        
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        
        leagueCollectionView.dataSource = self
        leagueCollectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configureCalendarCell()
        configureLeagueCell()
        configureRecentMatchCell()
        
        
        fixtureViewModel.getDateInfoForCurrentYear()
        fixtureViewModel.fetcMatch()
        setupBinder()

    }
    
    func configureHeaderView() {
        headerBackground.clipsToBounds = true
        headerBackground.layer.cornerRadius = 20
        headerBackground.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        headerBackground.dropShadow()
    }
    
    func configureCalendarCell(){
        let calendarCollectionCellNib = UINib(nibName: Constants.calendarCollectionViewCellId, bundle: nil)
        calendarCollectionView.register(calendarCollectionCellNib, forCellWithReuseIdentifier: Constants.calendarCollectionViewCellId)

        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.itemSize = CGSize(width: 70, height: 70)
        collectionViewCellLayout.scrollDirection = .horizontal
        calendarCollectionView.collectionViewLayout = collectionViewCellLayout
    }
    
    func configureLeagueCell(){
        let leagueCollectionCellNib = UINib(nibName: Constants.leagueCollectionViewCellId, bundle: nil)
        calendarCollectionView.register(leagueCollectionCellNib, forCellWithReuseIdentifier: Constants.leagueCollectionViewCellId)

        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.itemSize = CGSize(width: 100, height: 100)
        collectionViewCellLayout.scrollDirection = .horizontal
        calendarCollectionView.collectionViewLayout = collectionViewCellLayout
    }
    
    func configureRecentMatchCell(){
        let recentMatchNib = UINib(nibName: Constants.recentMatchTVCellId, bundle: nil)
        tableView.register(recentMatchNib, forCellReuseIdentifier: Constants.recentMatchTVCellId)
    }
    
    
    func setupBinder() {
        fixtureViewModel.$dateList.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.calendarCollectionView.reloadData()
                self?.scrollToIndex(index: self?.fixtureViewModel.todaysIndex ?? 0)
            }
        }.store(in: &cancellables)
        
        fixtureViewModel.$matchList.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    func scrollToIndex(index: Int, animated: Bool = false) {
        let indexPath = IndexPath(item: index, section: 0)
        self.calendarCollectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
    }
}


extension FixtureViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
                case 0:
                    return fixtureViewModel.dateList?.count ?? 0
                case 1:
                    return LeagueInfo.LeagueInfoList.count
                default:
                    return 0
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
                case 0:
                    let calendarCell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.calendarCollectionViewCellId, for: indexPath) as? CalendarCollectionViewCell
                    
                    guard let calendarCell = calendarCell else { return UICollectionViewCell() }
                    
                    calendarCell.day.text = fixtureViewModel.dateList?[indexPath.row].day
                    calendarCell.date.text = String(fixtureViewModel.dateList?[indexPath.row].dayNumber ?? 0)
                    return calendarCell
                case 1:
                    let leagueCell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.leagueCollectionViewCellId, for: indexPath) as? LeagueCollectionViewCell
                    
                    guard let leagueCell = leagueCell else { return UICollectionViewCell() }
                    
                    leagueCell.leagueName.text = LeagueInfo.LeagueInfoList[indexPath.row].name
                    leagueCell.leagueImage.sd_setImage(
                        with: URL(string: LeagueInfo.LeagueInfoList[indexPath.row].img_path ?? ""),
                        placeholderImage: UIImage(named: "teamLogo")
                    )
                    return leagueCell
                default:
                    return UICollectionViewCell()
            }
    }
    
}

extension FixtureViewController: UICollectionViewDelegate {
    
}


extension FixtureViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchCell = tableView.dequeueReusableCell(withIdentifier: Constants.recentMatchTVCellId, for: indexPath) as? RecentMatchTVCell
        
        guard let matchCell = matchCell else { return UITableViewCell() }

        guard let matchList = fixtureViewModel.matchList else { return UITableViewCell() }

        matchCell.setMatch(matchInfo: matchList[indexPath.row])
        
        return matchCell
    }
}

extension FixtureViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let matchCell = fixtureViewModel.matchList else { return }
        
        fixtureViewModel.goToMatchDetailsPage(matchId: matchCell[indexPath.row].id ?? 0, isLive: false, originVC: self)
    }
   
}


extension FixtureViewController: UICollectionViewDelegateFlowLayout
{
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       switch collectionView.tag {
               case 0:
                   return CGSize(width: 55, height: 60)
               case 1:
                   return CGSize(width: 100, height: 100)
               default:
                   return CGSize(width: 130, height: 130)
           }
           
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0
   }
}
