//
//  VBMenuTableViewCell.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 9/16/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
