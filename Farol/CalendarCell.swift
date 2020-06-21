//
//  CalendarCell.swift
//  Farol
//
//  Created by Rodrigo Lemos on 05/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    
    var day: HabitDate? {
        didSet {
            dayLabel.text = day?.day
            weekDayLabel.text = day?.weekDay
            
            if day?.trashDays == false && day?.habitDay == false {
                dayLabel.textColor = .lightGray
                weekDayLabel.textColor = .lightGray
            } else {
                dayLabel.textColor = .black
                weekDayLabel.textColor = .black
            }
                       
            if day?.trashDays == false && day?.habitDay == true {
                selectedImage.image = UIImage(named: "bolinhaVazia")
            } else {
                selectedImage.image = nil
            }
           
            if day?.trashDays == false && day?.completed == true  {
                selectedImage.image = UIImage(named: "bolinhaCheia")
            }
            
            if day?.badUI == true {
                selectedImage.image = UIImage(named: "bolinhaVermelha")
            }
        }
    }
    
}
