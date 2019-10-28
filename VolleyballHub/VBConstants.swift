//
//  VBConstants.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/16/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import Foundation

struct K {
    
    struct UserDefaultsKeys {
        static let currentTeamName = "currentTeamNameKey"
    }
    
    struct TableView {
        struct Menu {
            static let reuseID = "menuCellReuseID"
            
            struct SegueID {
                static let menu_createTeam = "Menu_CreateTeam"
                static let menu_switchTeam = "Menu_SwitchTeam"
                static let menu_editRoster = "Menu_EditRoster"
            }
        }
        
        struct SwitchTeam {
            static let reuseID = "switchTeamCellReuseID"
        }
        
        struct Roster {
            static let reuseID = "playerCellReuseID"
        }
    }
    
    struct SegueID {
        static let roster_editPlayer = "Roster_EditPlayer"
    }
    
    enum Positions: String {
        case Setter = "Setter"
        case Outside = "Outside"
        case Middle = "Middle"
        case Opposite = "Opposite"
        case DefensiveSpecialist = "Defensive Specialist"
        case Libero = "Libero"
        
        static let allValues: [String] = [Setter.rawValue, Outside.rawValue, Middle.rawValue, Opposite.rawValue, DefensiveSpecialist.rawValue, Libero.rawValue]
    }
}
