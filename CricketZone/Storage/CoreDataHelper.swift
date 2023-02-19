//
//  CoreDataHelper.swift
//  CricketZone
//
//  Created by Shahnewaz on 20/2/23.
//

import Foundation


import Foundation
import UIKit
import CoreData

class CoreDataHelper{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let shared = CoreDataHelper()

    
    func addPlayer(player: PlayerInfo){
        
        guard let id = player.id, let fullName = player.fullname, let imagePath = player.image_path else { return }
                
        let newPlayer = PlayerModel(context: context)
            
        newPlayer.id = Int64(id)
        newPlayer.fullName = fullName
        newPlayer.imagePath = imagePath
        do {
            try context.save()
        } catch {
            print(error)
        }
       
    }
    
    
    func getAllPlayers() {
        let fetchRequest = NSFetchRequest<PlayerModel>(entityName: "PlayerModel")
        let format = ""
        let predicate = NSPredicate(format: format)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 15
        
        do {
            PlayerModel.playerList = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
}
