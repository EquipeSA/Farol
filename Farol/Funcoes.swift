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
