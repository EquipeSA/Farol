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
    init(defaultScene: UIImage,animatedScene:[UIImage],currentScene:UIImage,animateTime:Double,animateRepeat:Int) {
        self.defaultScene = defaultScene
        self.animatedScene = animatedScene
        self.currentScene = currentScene
        self.animateTime = animateTime
        self.animateRepeat = animateRepeat
        
    }
    
    let defaultScene: UIImage
    let animatedScene: [UIImage]
    let currentScene: UIImage
    let animateTime:Double
    let animateRepeat:Int
}

func storyScenes() -> [SceneManager]{
    var storyScenes:[SceneManager] = []
    
    let scene1 = SceneManager(
        defaultScene: UIImage(named: "backgroundFarolELua")!,
        animatedScene: createImageArray(imagePrefix: "farolAcendendo"),
        currentScene: UIImage(named: "farolAcendendo-2")!, animateTime: 1, animateRepeat: 2)
    
    let scene2 = SceneManager(
        defaultScene: UIImage(named: "alternativeBack")!,
        animatedScene: createImageArray(imagePrefix: "cadente"),
        currentScene: UIImage(named: "cadente")!,animateTime:1,animateRepeat: 2)
    
    let scene3 = SceneManager(
        defaultScene: UIImage(named: "backgroundFarolELua")!,
        animatedScene: createImageArray(imagePrefix: "fatcat"),
        currentScene: UIImage(named: "fatcat")!,animateTime:3.5,animateRepeat: 3)
    
    let scene4 = SceneManager(
    defaultScene: UIImage(named: "backgroundFarolELua")!,
    animatedScene: createImageArray(imagePrefix: "boreal"),
    currentScene: UIImage(named: "boreal")!,animateTime:5,animateRepeat: 3)
    
    storyScenes.append(scene4)
    storyScenes.append(scene1)
    storyScenes.append(scene2)
    storyScenes.append(scene3)
    return storyScenes
}
