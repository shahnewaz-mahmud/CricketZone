//
//  UserDefaultsHelper.swift
//  CricketZone
//
//  Created by Shahnewaz on 20/2/23.
//

import Foundation


import Foundation

class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    
    func saveAllSeasons(seasonList: [Int: String], key: String){
        
        print("Seasons ",seasonList)
        let encoder = JSONEncoder()
        let data = try? encoder.encode(seasonList)

        UserDefaults.standard.set(data, forKey: key)
    }

    func getSavedSeasons(key: String) -> [Int: String]?{
        guard let fetchedData = UserDefaults.standard.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        let allSeasons = try? decoder.decode([Int: String].self, from: fetchedData)
        return allSeasons

    }

    func removeSavedData(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }

}
