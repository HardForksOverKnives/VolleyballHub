//
//  VBTableViewCellInfo.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 10/13/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

struct VBTableViewCellInfo {
    
    typealias CellTappedMethodHandler = () -> Void

    let reuseID: String
    let text: String
    var imageName: String?
    var segueName: String?
    var function: CellTappedMethodHandler?
    
    init(reuseID: String, text: String, imageName: String? = nil, segueName: String? = nil, function: CellTappedMethodHandler? = nil) {
        self.reuseID = reuseID
        self.text = text
        self.imageName = imageName
        self.segueName = segueName
        self.function = function
    }
}
