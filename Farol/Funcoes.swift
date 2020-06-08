//
//  File.swift
//  Farol
//
//  Created by yury antony on 04/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import Foundation

func calenDays(numOfDays:Int)->[String]{
    let cal = Calendar.current
    var date = cal.startOfDay(for: Date())
    var days = [String]()
    for i in 1 ... numOfDays {
        let day = cal.component(.day, from: date)
        let strDay = String(day)
        days.append(strDay)
        date = cal.date(byAdding: .day, value: 1, to: date)!
    }
    return days
}

