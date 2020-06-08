//
//  ChallengeDate.swift
//  Farol
//
//  Created by Rodrigo Lemos on 08/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

class ChallengeDate {
    
    init(day: String, weekDay: String, completed: Bool) {
        self.day = day
        self.weekDay = weekDay
        self.completed = completed
    }
    let day: String
    let weekDay: String
    let completed: Bool
}
