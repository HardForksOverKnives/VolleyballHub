//
//  VBPersistentContainer.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/19/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import CoreData
import UIKit

class VBPersistentContainer: NSPersistentContainer {

    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
}
