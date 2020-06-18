//
//  File.swift
//  Farol
//
//  Created by yury antony on 04/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

func calenDays(numOfDays:Int) -> [HabitDate]{
    let calendar = Calendar.current
    var date = calendar.startOfDay(for: Date())
    var habitDays = [HabitDate]()
    let scenes = storyScenes()
    
    for _ in 1 ... 4 {
        let week = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let strDay = String(day)
        let strWeek = convertToWeekString(correspondingNumber: week)
        habitDays.append(HabitDate(day: strDay, weekDay: strWeek, completed: false, selecionavel: false, habitDay: false, trashDays: true, insight: nil, date: nil, incompleted: true, badUI: false,scenes: scenes[0]))
        date = calendar.date(byAdding: .day, value: -1, to: date)!
    }
    habitDays.reverse()
    habitDays.remove(at: 3)
    date = calendar.startOfDay(for: Date())
    for i in 1 ... numOfDays {
        let week = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let strDay = String(day)
        let strWeek = convertToWeekString(correspondingNumber: week)
        let scenesLength = scenes.count
        var correspondentScene:SceneManager
        if i <= scenesLength{
            correspondentScene = scenes[i-1]
            print("sera???")
        }else{
            correspondentScene = scenes[0]
            print("Ta entrando aqui")
        }
        habitDays.append(HabitDate(day: strDay, weekDay: strWeek, completed: false, selecionavel: false, habitDay: false, trashDays: false, insight: nil, date: nil, incompleted: true, badUI: false, scenes: correspondentScene))
        date = calendar.date(byAdding: .day, value: 1, to: date)!
    }
    return habitDays
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

func getTodayNumberInt() -> Int {
    let today = getCurrentDate()
    let todayWithoutComma = today.replacingOccurrences(of: ",", with: "")
    
    let splitToday = todayWithoutComma.components(separatedBy: " ")
    let day = splitToday[1]
    
    let returnDay = Int(day)!
    return returnDay
}

func fade(imageView: UIImageView, toImage: UIImage) {
    UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
        imageView.image = toImage
    }, completion: nil)
}


func createImageArray(imagePrefix: String) -> [String] {
    var imageArray: [String] = []
    var aux = true
    var imageCount = 0
    while aux {
        let imageName = "\(imagePrefix)-\(imageCount).pdf"
        if let image = try? UIImage(named: imageName){
            imageArray.append(imageName)
            imageCount+=1
        } else {
            aux = false
        }
    }
    return imageArray
}


func animateScene(imageView: UIImageView, images: [String],duration:Double = 1,repeatCount:Int) {
    var imageArray: [UIImage] = []
    for img in images{
        let image = UIImage(named: img)!
        imageArray.append(image)
    }
    imageView.animationImages = imageArray
    imageView.animationDuration = duration
    imageView.animationRepeatCount = repeatCount
    imageView.startAnimating()
}
