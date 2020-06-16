//
//  SceneManager.swift
//  Farol
//
//  Created by yury antony on 15/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import Foundation
import UIKit

class SceneManager {
    
    init(defaultScene: UIImage,animatedScene:[UIImage],currentScene:UIImage) {
        self.defaultScene = defaultScene
        self.animatedScene = animatedScene
        self.currentScene = currentScene
        
    }
    
    let defaultScene: UIImage
    let animatedScene: [UIImage]
    let currentScene: UIImage
}
let defaultScene = UIImage(named: "backgroundFarolELua")
let animatedScene = createImageArray(imagePrefix: "farolAcendendo")
let currentScene = UIImage(named: "farolAcendendo-2")
let DEFAULTSCENES = SceneManager(defaultScene: defaultScene!, animatedScene: animatedScene, currentScene: currentScene!)
