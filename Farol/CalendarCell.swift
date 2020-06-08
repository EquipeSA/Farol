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
        }
    }
    
}
