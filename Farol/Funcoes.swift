//
//  File.swift
//  Farol
//
//  Created by yury antony on 04/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import Foundation

struct WeekCalendar{
    var weekDay:String
    var day:String
}
func calenDays(numOfDays:Int) -> [WeekCalendar]{
    let calendar = Calendar.current
    var date = calendar.startOfDay(for: Date())

    var weekDays = [WeekCalendar]()
    for _ in 1 ... 4 {
        let week = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let strDay = String(day)
        let strWeek = convertToWeekString(correspondingNumber: week)
        let weekDay = WeekCalendar(weekDay: strWeek, day: strDay)
        weekDays.append(weekDay)
        date = calendar.date(byAdding: .day, value: -1, to: date)!
    }
    weekDays.reverse()
    weekDays.remove(at: 3)
    date = calendar.startOfDay(for: Date())
    for _ in 1 ... numOfDays {
        let week = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let strDay = String(day)
        let strWeek = convertToWeekString(correspondingNumber: week)
        let weekDay = WeekCalendar(weekDay: strWeek, day: strDay)
        weekDays.append(weekDay)
        date = calendar.date(byAdding: .day, value: 1, to: date)!
    }
    return weekDays
}

func convertToWeekString(correspondingNumber number:Int)->String{
    switch number {
    case 1:
        return "D"
    case 2:
        return "S"
    case 3:
        return "T"
    case 4:
        return "Q"
    case 5:
        return "Q"
    case 6:
        return "S"
    case 7:
        return "S"
    default:
       return  "problem with date"
    }
}

func getCurrentDate() -> String {
    let currentDate = Date()
    let formatter = DateFormatter()
    formatter.timeStyle = .none
    formatter.dateStyle = .long
    let dateString = formatter.string(from: currentDate)
    return dateString
}
