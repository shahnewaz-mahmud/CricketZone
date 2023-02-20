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

    func addItems(data: PlayerList) {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        
        privateContext.performAndWait {
            guard let entity = NSEntityDescription.entity(forEntityName: "PlayerModel", in: privateContext) else {
                return
            }

            for item in data {
                print("Saving Player \(String(describing: item.id))")
                
                let dataObject = NSManagedObject(entity: entity, insertInto: privateContext)
                dataObject.setValue(item.id, forKey: "id")
                dataObject.setValue(item.fullname, forKey: "fullName")
                dataObject.setValue(item.image_path, forKey: "imagePath")
            }

            do {
                try privateContext.save()
                context.performAndWait {
                    do {
                        try context.save()
                        print("Saving Completed")
                    } catch let error as NSError {
                        print("Could not save to the main context. \(error), \(error.userInfo)")
                    }
                }
            } catch let error as NSError {
                print("Could not save to the private context. \(error), \(error.userInfo)")
            }
        }
    }
    

    
    func searchPlayers(searchText: String) -> [PlayerModel] {
        
        let fetchRequest = NSFetchRequest<PlayerModel>(entityName: "PlayerModel")
        let format = "fullName CONTAINS[c] %@"
        fetchRequest.fetchLimit = 15

        print(format)

        let predicate = NSPredicate(format: format,searchText)
        fetchRequest.predicate = predicate
        
        do {
            let playerList = try context.fetch(fetchRequest)
            return playerList
        } catch {
            print(error)
            return [PlayerModel]()
        }
    }
    
}
