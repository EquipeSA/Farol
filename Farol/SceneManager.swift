//
//  SceneManager.swift
//  Farol
//
//  Created by yury antony on 17/06/20.
//  Copyright © 2020 yuryAntony. All rights reserved.
//

import Foundation
import UIKit

class SceneManager: Codable{
    init(defaultScene: String,animatedScene:[String],currentScene:String,animateTime:Double,animateRepeat:Int) {
        self.defaultScene = defaultScene
        self.animatedScene = animatedScene
        self.currentScene = currentScene
        self.animateTime = animateTime
        self.animateRepeat = animateRepeat
        
    }
    
    let defaultScene: String
    let animatedScene: [String]
    let currentScene: String
    let animateTime:Double
    let animateRepeat:Int
}

func storyScenes() -> [SceneManager]{
    var storyScenes:[SceneManager] = []

    let scene1 = SceneManager(
        defaultScene:  "backgroundFarolELua",
        animatedScene: createImageArray(imagePrefix: "farolAcendendo"),
        currentScene: "farolAcendendo-2", animateTime: 1, animateRepeat: 2)

    let scene2 = SceneManager(
        defaultScene: "backgroundFarolELua",
        animatedScene: createImageArray(imagePrefix: "cadente"),
        currentScene: "cadente",animateTime:2,animateRepeat: 3)

    let scene3 = SceneManager(
        defaultScene: "backgroundFarolELua",
        animatedScene: createImageArray(imagePrefix: "fatcat"),
        currentScene: "fatcat",animateTime:3.5,animateRepeat: 3)
    
    let scene4 = SceneManager(
    defaultScene: "backgroundFarolELua",
    animatedScene: createImageArray(imagePrefix: "boreal"),
    currentScene: "boreal",animateTime:3.5,animateRepeat: 3)
    
    let scene5 = SceneManager(
    defaultScene: "backgroundFarolELua",
    animatedScene: createImageArray(imagePrefix: "camp"),
    currentScene: "camp",animateTime:1.5,animateRepeat: 3)
    
    let scene6 = SceneManager(
    defaultScene: "fogueteDefault",
    animatedScene: createImageArray(imagePrefix: "foguete"),
    currentScene: "foguete",animateTime:1.5,animateRepeat: 2)

    
    
    
    
    storyScenes.append(scene1)
    storyScenes.append(scene2)
    storyScenes.append(scene3)
    storyScenes.append(scene4)
    storyScenes.append(scene5)
    storyScenes.append(scene6)
    
    return storyScenes
}
