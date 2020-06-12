//
//  ChallengeDate.swift
//  Farol
//
//  Created by Rodrigo Lemos on 08/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

class ChallengeDate {
    
    init(day: String, weekDay: String, completed: Bool, selecionavel: Bool, challengeDay: Bool, trashDays: Bool) {
        self.day = day
        self.weekDay = weekDay
        self.completed = completed
        self.selecionavel = selecionavel
        self.challengeDay = challengeDay
        self.trashDays = trashDays
    }
    let day: String
    let weekDay: String
    let completed: Bool
    var selecionavel: Bool
    var trashDays: Bool
    var challengeDay: Bool
}
