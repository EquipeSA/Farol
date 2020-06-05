//
//  File.swift
//  Farol
//
//  Created by yury antony on 04/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import Foundation

func validLength(text:String,length:Int = 300)->Bool{
    let tam = text.count
    if tam > length{
        return false
    }
    return true
}

func calenDays(numOfDays:Int)->[Int]{
    let cal = Calendar.current
    var date = cal.startOfDay(for: Date())
    var days = [Int]()
    for i in 1 ... numOfDays {
        let day = cal.component(.day, from: date)
        days.append(day)
        date = cal.date(byAdding: .day, value: 1, to: date)!
    }
    return days
}

