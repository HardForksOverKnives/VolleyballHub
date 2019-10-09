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

    static func allTeams(context: NSManagedObjectContext) -> [VBTeamMO] {
        let request: NSFetchRequest<VBTeamMO> = VBTeamMO.fetchRequest()

        do {
            let fetchedTeams = try context.fetch(request) as [VBTeamMO]
            return fetchedTeams
        } catch {
            fatalError("Failed to fetch teams: \(error)")
        }
    }
    
    // saves team if name isn't already taken
    static func saveTeam(name: String, coach: String, container: VBPersistentContainer) -> Bool {
        let team = teamWithUniqueName(name: name, coach: coach, context: container.viewContext)
        container.saveContext()
        return (team != nil)
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
}
