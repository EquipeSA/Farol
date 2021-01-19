//
//  Extensions.swift
//  Farol
//
//  Created by Rodrigo Lemos on 15/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import UIKit

extension UIView {
   func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
       if #available(iOS 11, *) {
           var cornerMask = CACornerMask()
           if(corners.contains(.topLeft)){
               cornerMask.insert(.layerMinXMinYCorner)
           }
           if(corners.contains(.topRight)){
               cornerMask.insert(.layerMaxXMinYCorner)
           }
           if(corners.contains(.bottomLeft)){
               cornerMask.insert(.layerMinXMaxYCorner)
           }
           if(corners.contains(.bottomRight)){
               cornerMask.insert(.layerMaxXMaxYCorner)
           }
           self.layer.cornerRadius = radius
           self.layer.maskedCorners = cornerMask

       } else {
           let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           self.layer.mask = mask
       }
   }
}

extension Date {
    var dayAfter: Date {
        //var after = Calendar.current.date(byAdding: .day, value: 1, to: self)!
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
