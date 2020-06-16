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

func storyScenes() -> [SceneManager]{
    var storyScenes:[SceneManager] = []

    let scene1 = SceneManager(
        defaultScene: UIImage(named: "backgroundFarolELua")!,
        animatedScene: createImageArray(imagePrefix: "farolAcendendo"),
        currentScene: UIImage(named: "farolAcendendo-2")!)
    storyScenes.append(scene1)

    let scene2 = SceneManager(
        defaultScene: UIImage(named: "alternativeBack")!,
        animatedScene: createImageArray(imagePrefix: "cadente"),
        currentScene: UIImage(named: "cadente")!)
    storyScenes.append(scene2)
    return storyScenes
}
