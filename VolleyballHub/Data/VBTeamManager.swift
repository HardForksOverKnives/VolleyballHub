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
    
    static func saveTeam(name: String, coach: String, container: VBPersistentContainer) -> Bool {
        if (isTeamNameTaken(name: name, context: container.viewContext)) {
            return false
        }
        
        let team = NSEntityDescription.insertNewObject(forEntityName: "VBTeam", into: container.viewContext) as! VBTeamMO
        team.name = name
        team.coach = coach
        container.saveContext()
        return true
    }
    
    static private func isTeamNameTaken(name: String, context: NSManagedObjectContext) -> Bool {
        let teams = VBTeamManager.allTeams(context: context)
        
        var nameIsTaken = false
        for team in teams {
            if (team.name == name) {
                nameIsTaken = true
                break
            }
        }
        
        return nameIsTaken
    }
}
