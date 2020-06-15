//
//  File.swift
//  Farol
//
//  Created by yury antony on 04/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

func calenDays(numOfDays:Int) -> [ChallengeDate]{
    let calendar = Calendar.current
    var date = calendar.startOfDay(for: Date())
    var challengeDays = [ChallengeDate]()
    
    for _ in 1 ... 4 {
        let week = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let strDay = String(day)
        let strWeek = convertToWeekString(correspondingNumber: week)
        challengeDays.append(ChallengeDate(day: strDay, weekDay: strWeek, completed: false, selecionavel: false, challengeDay: false, trashDays: true, insight: nil, date: nil))
        date = calendar.date(byAdding: .day, value: -1, to: date)!
    }
    challengeDays.reverse()
    challengeDays.remove(at: 3)
    date = calendar.startOfDay(for: Date())
    for _ in 1 ... numOfDays {
        let week = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let strDay = String(day)
        let strWeek = convertToWeekString(correspondingNumber: week)
        challengeDays.append(ChallengeDate(day: strDay, weekDay: strWeek, completed: false, selecionavel: false, challengeDay: false, trashDays: false, insight: nil, date: nil))
        date = calendar.date(byAdding: .day, value: 1, to: date)!
    }
    return challengeDays
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

func getTodayNumber() -> String {
    let today = getCurrentDate()
    let todayWithoutComma = today.replacingOccurrences(of: ",", with: "")
    
    let splitToday = todayWithoutComma.components(separatedBy: " ")
    let day = splitToday[1]
    return day
}

func fade(imageView: UIImageView, toImage: UIImage) {
    UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
        imageView.image = toImage
    }, completion: nil)
}
