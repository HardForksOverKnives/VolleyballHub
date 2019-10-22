//
//  VBTeamManager.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/25/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit
import CoreData

class VBTeamManager {
    
    static func getCurrentTeam(context: NSManagedObjectContext) -> VBTeamMO? {
        let currentTeamName = UserDefaults.standard.string(forKey: K.UserDefaultsKeys.currentTeamName)
        if (currentTeamName == nil) {
            return nil
        } else {
            return getTeamWithName(name: currentTeamName!, context: context)
        }
    }
    
    static func setCurrentTeam(name: String) {
        UserDefaults.standard.set(name, forKey: K.UserDefaultsKeys.currentTeamName)
    }

    static func allTeams(context: NSManagedObjectContext) -> [VBTeamMO] {
        let request: NSFetchRequest<VBTeamMO> = VBTeamMO.fetchRequest()

        do {
            let fetchedTeams = try context.fetch(request) as [VBTeamMO]
            return fetchedTeams
        } catch {
            fatalError("Failed to fetch teams: \(error)")
        }
    }
    
    // returns an array all team names
    static func allTeamNames(context: NSManagedObjectContext) -> [String] {
        let request: NSFetchRequest<NSFetchRequestResult> = VBTeamMO.fetchRequest()
        request.resultType = NSFetchRequestResultType.dictionaryResultType
        request.returnsDistinctResults = true
        request.propertiesToFetch = ["name"]
        
        do {
            let fetchedNamesDict = try context.fetch(request) as! [NSDictionary]
            var names: [String] = []
            for dict in fetchedNamesDict {
                names.append(dict.value(forKey: "name") as! String)
            }
            return names
        } catch {
            fatalError("Failed to fetch teams: \(error)")
        }
    }
    
    // saves team if name isn't already taken, and sets it to the current team
    static func saveTeam(name: String, coach: String, container: VBPersistentContainer) -> Bool {
        let team = teamWithUniqueName(name: name, coach: coach, context: container.viewContext)
        let success = (team != nil)
        if (success) {
            container.saveContext()
            setCurrentTeam(name: name)
        }
        return success
    }
    
    static func playersOnCurrentTeam(context: NSManagedObjectContext) -> [VBPlayerMO]? {
        if let team = getCurrentTeam(context: context) {
            if let players = team.players?.allObjects as! [VBPlayerMO]? {
                return players
            }
        }
        return nil
    }
    
    static func addPlayerToCurrentTeam(name: String, strongestPosition: String, secondStrongestPosition: String, number: Int16, container: VBPersistentContainer) -> Bool {
        if let team = getCurrentTeam(context: container.viewContext) {
            if let player = playerWithUniqueNumber(name: name, strongestPosition: strongestPosition, secondStrongestPosition: secondStrongestPosition, number: number, team: team, context: container.viewContext) {
                team.addToPlayers(player)
                container.saveContext()
                return true
            }
        }
        return false
    }
    
    static private func playerWithUniqueNumber(name: String, strongestPosition: String, secondStrongestPosition: String, number: Int16, team: VBTeamMO, context: NSManagedObjectContext) -> VBPlayerMO? {
        let player = NSEntityDescription.insertNewObject(forEntityName: "VBPlayer", into: context) as! VBPlayerMO
        player.name = name
        player.position1 = strongestPosition
        player.position2 = secondStrongestPosition
        player.number = number
        return player
    }
    
    // returns new VBteamMO if name isn't already taken
    static private func teamWithUniqueName(name: String, coach: String, context: NSManagedObjectContext) -> VBTeamMO? {
        if (getTeamWithName(name: name, context: context) != nil) {
            return nil
        } else {
            let team = NSEntityDescription.insertNewObject(forEntityName: "VBTeam", into: context) as! VBTeamMO
            team.name = name
            team.coach = coach
            return team
        }
    }
    
    // returns team with a given name if it already exists, nil otherwise
    static private func getTeamWithName(name: String, context: NSManagedObjectContext) -> VBTeamMO? {
        let request: NSFetchRequest<VBTeamMO> = VBTeamMO.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let fetchedTeams = try context.fetch(request) as [VBTeamMO]
            return fetchedTeams.first
        } catch {
            fatalError("Failed to fetch teams: \(error)")
        }
    }
    
//    ipad pro 9.7: /Users/connordunham/Library/Developer/CoreSimulator/Devices/3E1A21E7-1F9C-4740-B168-6E0028962FB1/data/Containers/Data/Application/914D2175-375A-4487-81F5-9FD8C14557BB/Library/Application Support/
    static func printDBLocation() {
        print("SQLite DB file for simulator found here: ", FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
}
