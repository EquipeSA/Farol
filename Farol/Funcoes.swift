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
    for i in 1 ... 4 {
        let day = cal.component(.day, from: date)
        let strDay = String(day)
        days.append(strDay)
        date = cal.date(byAdding: .day, value: -1, to: date)!
    }
    days.reverse()
    days.remove(at: 3)
    date = cal.startOfDay(for: Date())
    for i in 1 ... numOfDays {
        let day = cal.component(.day, from: date)
        let strDay = String(day)
        days.append(strDay)
        date = cal.date(byAdding: .day, value: 1, to: date)!
    }
    
    return days
}

func getSequenceDaysOfWeek(dayOfWeek: Int) -> [String] {
    switch dayOfWeek {
    case 1:
        return ["S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S"]
    case 2:
        return ["M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M"]
    case 3:
        return ["T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T"]
    case 4:
        return ["W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W"]
    case 5:
        return ["T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T"]
    case 6:
        return ["F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F"]
    case 7:
        return ["S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S","S","M","T","W","T","F","S"]
    default:
        print("problem with get Date")
        return ["problem with date"]
    }
}

func getCurrentDate() -> String {
    let currentDate = Date()
    let formatter = DateFormatter()
    formatter.timeStyle = .none
    formatter.dateStyle = .long
    var dateString = formatter.string(from: currentDate)
    return dateString
}

func getDayOfWeek() -> Int {
    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.weekday], from: date)
    let dayOfWeek = components.weekday
    guard let day = dayOfWeek else { return -1}
    print(day)
    return day
}
