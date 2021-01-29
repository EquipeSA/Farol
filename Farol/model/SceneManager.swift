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
    init(sceneName:String,animateTime:Double,animateRepeat:Int) {
        self.defaultScene = "DefaultLighthouseAndStars"
        self.animatedScene = createImageArray(imagePrefix: sceneName)
        self.currentScene = sceneName
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

    storyScenes.append(SceneManager(sceneName: "LightOn", animateTime: 1, animateRepeat: 1))
    storyScenes.append(SceneManager(sceneName: "cadente",animateTime:2,animateRepeat: 3))
    storyScenes.append(SceneManager(sceneName: "fatcat",animateTime:3.5,animateRepeat: 3))
    storyScenes.append(SceneManager(sceneName: "boreal",animateTime:3.5,animateRepeat: 3))
    storyScenes.append(SceneManager(sceneName: "camp",animateTime:1.5,animateRepeat: 3))
    storyScenes.append(SceneManager(sceneName: "foguete",animateTime:1.5,animateRepeat: 2))
    
    return storyScenes
}
