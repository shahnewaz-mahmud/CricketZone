//
//  PlayerModel+CoreDataProperties.swift
//  CricketZone
//
//  Created by Shahnewaz on 20/2/23.
//
//

import Foundation
import CoreData


extension PlayerModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerModel> {
        return NSFetchRequest<PlayerModel>(entityName: "PlayerModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var fullName: String?
    @NSManaged public var imagePath: String?
    
    static var playerList = [PlayerModel]()

}

extension PlayerModel : Identifiable {

}
