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
    }
}
