//
//  ChallengeDate.swift
//  Farol
//
//  Created by Rodrigo Lemos on 08/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

class ChallengeDate {
    
    init(day: String, weekDay: String, completed: Bool, selecionavel: Bool, challengeDay: Bool, trashDays: Bool, insight: String?, date: String?, testDay: String?) {
        self.day = day
        self.weekDay = weekDay
        self.completed = completed
        self.selecionavel = selecionavel
        self.challengeDay = challengeDay
        self.trashDays = trashDays
        self.insight = insight
        self.date = date
        self.testDay = testDay
    }
    
    let day: String
    let weekDay: String
    var insight: String?
    var completed: Bool
    var selecionavel: Bool
    var trashDays: Bool
    var challengeDay: Bool
    var date: String?
    var testDay: String?
}
