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
    
    var day: ChallengeDate? {
        didSet {
            dayLabel.text = day?.day
            weekDayLabel.text = day?.weekDay
            
            if day?.completed == true {
                selectedImage.image = UIImage(named: "bolinhaCheia")
            } else {
                selectedImage.image = UIImage(named: "bolinhaVazia")
            }
                       
            if day?.trashDays == false && day?.challengeDay == true {
                selectedImage.image = UIImage(named: "bolinhaVazia")
            } else {
                selectedImage.image = nil
            }
            
            if day?.trashDays == false && day?.challengeDay == false {
                dayLabel.textColor = .red
                weekDayLabel.textColor = .red
            } else {
                dayLabel.textColor = .black
                weekDayLabel.textColor = .black
            }
        }
    }
    
}
