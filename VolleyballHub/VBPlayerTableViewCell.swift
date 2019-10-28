//
//  VBPlayerTableViewCell.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 10/24/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//

import UIKit

class VBPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpForPlayer(player: VBPlayerMO) {
        playerNameLabel.text = player.name ?? "No Name"
        playerNumberLabel.text = String(player.number)
        
        for view in playerPositionsStackView.arrangedSubviews {
            playerPositionsStackView.removeArrangedSubview(view)
        }
        
        if let position1 = player.position1 {
            let v = UIView.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            v.backgroundColor = colorForPosition(position: position1)
            playerPositionsStackView.addArrangedSubview(v)
        }
        
        if let position2 = player.position2 {
            let v = UIView.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            v.backgroundColor = colorForPosition(position: position2)
            playerPositionsStackView.addArrangedSubview(v)
        }
    }

    private func colorForPosition(position: String?) -> UIColor {
        switch (position) {
        case K.Positions.DefensiveSpecialist.rawValue:
            return .black
        case K.Positions.Libero.rawValue:
            return .gray
        case K.Positions.Middle.rawValue:
            return .blue
        case K.Positions.Setter.rawValue:
            return .red
        case K.Positions.Outside.rawValue:
            return .purple
        case K.Positions.Opposite.rawValue:
            return .green
        default:
            return .white
        }
    }
}
