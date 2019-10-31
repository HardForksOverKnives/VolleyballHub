//
//  VBSet.swift
//  VolleyballHub
//
//  Created by Connor Dunham on 10/29/19.
//  Copyright © 2019 Connor Dunham. All rights reserved.
//


class VBSet {
    var pointsForWin: Int
    var winBy2: Bool
    var team1: VBSetTeam
    var team2: VBSetTeam
    
    init(pointsForWin: Int = 25, winBy2: Bool = true, team1Serves: Bool = true) {
        self.pointsForWin = pointsForWin
        self.winBy2 = winBy2
        self.team1 = VBSetTeam(score: 0, isServing: team1Serves, lineUp: [0, 1, 2, 3, 4, 5])
        self.team2 = VBSetTeam(score: 0, isServing: !team1Serves, lineUp: [0, 1, 2, 3, 4, 5])
    }
    
    func servingPoint() {
        var team = self.team1.isServing ? team1 : team2
        team.score += 1
    }
    
    func point(isSideOut: Bool) {
        if (!isSideOut) {
            var scoringTeam = team1.isServing ? team1 : team2
            scoringTeam.score += 1
        } else {
            var sideOutTeam = team1.isServing ? team2 : team1
            var losingTeam = team1.isServing ? team1 : team2
            sideOutTeam.score += 1
            sideOutTeam.isServing = true
            losingTeam.isServing = false
        }
    }
    
    func sideOutPoint() {
        point(isSideOut: true)
    }
    
    func servePoint() {
        point(isSideOut: false)
    }
    
    func hasWinner() -> Bool {
        return winner() != nil
    }
    
    func winner() -> VBSetTeam? {
        var winner: VBSetTeam? = nil
        
        if (winBy2 && abs(team1.score - team2.score) < 2) {
            winner = nil
        } else if (team1.score >= pointsForWin && team1.score > team2.score) {
            winner = team1
        } else if (team2.score >= pointsForWin && team2.score > team1.score) {
            winner = team2
        }
        
        return winner
    }
}

struct VBSetTeam {
    var name = ""
    var score = 0
    var isServing = false
    var lineUp: [Int] = []
}
