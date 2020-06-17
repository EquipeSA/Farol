//
//  HabitDate.swift
//  Farol
//
//  Created by Rodrigo Lemos on 08/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

class HabitDate: Codable {
    
    init(day: String, weekDay: String, completed: Bool, selecionavel: Bool, habitDay: Bool, trashDays: Bool, insight: String?, date: String?, incompleted: Bool, badUI: Bool,scenes:SceneManager) {
        self.day = day
        self.weekDay = weekDay
        self.completed = completed
        self.selecionavel = selecionavel
        self.habitDay = habitDay
        self.trashDays = trashDays
        self.insight = insight
        self.date = date
        self.incompleted = incompleted
        self.badUI = badUI
        self.scenes = scenes
    }
    
    let day: String
    let weekDay: String
    var insight: String?
    var completed: Bool
    var selecionavel: Bool
    var trashDays: Bool
    var habitDay: Bool
    var date: String?
    var incompleted: Bool
    var badUI: Bool
    var scenes: SceneManager
}

import UIKit
