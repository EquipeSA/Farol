//
//  habitCalendarDataManager.swift
//  Farol
//
//  Created by yury antony on 19/01/21.
//  Copyright © 2021 yuryAntony. All rights reserved.
//

import Foundation
import CoreData

internal struct HabitDayDataManager{
    static let shared = HabitDayDataManager()
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("erro de load \(error)")
            }
        }
        return container
    }()
    //Criar e Salvar registro no banco
    func createHabitDay(date:String,day:String,dayInsight:String,isBadUI:Bool,isCompleted:Bool,
                         isHabitDay:Bool,isIncompleted:Bool,isSelectable:Bool,isTrashDay:Bool,
                         weekDay:String) -> HabitDay? {
        
        let context = persistentContainer.viewContext
        let habitDayDetails = NSEntityDescription.insertNewObject(forEntityName: "HabitDay",
                                                                  into: context) as! HabitDay
        
        habitDayDetails.date = date
        habitDayDetails.day = day
        habitDayDetails.dayInsight = dayInsight
        habitDayDetails.isBadUI = isBadUI
        habitDayDetails.isCompleted = isCompleted
        habitDayDetails.isHabitDay = isHabitDay
        habitDayDetails.isIncompleted = isIncompleted
        habitDayDetails.isSelectable = isSelectable
        habitDayDetails.isTrashDay = isTrashDay
        habitDayDetails.weekDay = weekDay
        
        do {
            try context.save()
            return habitDayDetails
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    //Listar registros do banco
    func fetchHabitDay() -> [HabitDay]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<HabitDay>(entityName: "HabitDay")
        
        do{
            let habitsInCalendar = try context.fetch(fetchRequest)
            return habitsInCalendar
        } catch let error{
            print("Fetch Failed: \(error)")
        }
        return nil
    }
    
    //Editar registros do banco
    func updateHabitDay(HabitDay: HabitDay){
        let context = persistentContainer.viewContext
        do{
            try context.save()
        } catch let updateError {
            print("Failed to update: \(updateError)")
        }
    }
    
    //Deletar Registro do banco
    func deleteHabitDay(HabitDay: HabitDay){
        let context = persistentContainer.viewContext
        context.delete(HabitDay)
        do{
            try context.save()
        } catch let deleteError {
            print("Failed to delete: \(deleteError)")
        }
    }
}
