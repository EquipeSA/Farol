//
//  HabitDate.swift
//  Farol
//
//  Created by Rodrigo Lemos on 08/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

class HabitDate {
    
    init(day: String, weekDay: String, completed: Bool, selecionavel: Bool, habitDay: Bool, trashDays: Bool, insight: String?, date: String?, testDay: String?,scenes:SceneManager = DEFAULTSCENES) {
        self.day = day
        self.weekDay = weekDay
        self.completed = completed
        self.selecionavel = selecionavel
        self.habitDay = habitDay
        self.trashDays = trashDays
        self.insight = insight
        self.date = date
        self.testDay = testDay
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
    var testDay: String?
    var scenes: SceneManager
}
