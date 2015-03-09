//
//  GameBreakWindow.swift
//  ColorBlocks
//
//  Created by Tim on 2015-02-02.
//  Copyright (c) 2015 Tim. All rights reserved.
//

import Foundation
import Foundation
import SpriteKit

class GameBreakWindow: SKSpriteNode {
    
    
    convenience init(rectOfSize size: CGSize) {
        self.init()
        self.size = size
        self.color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        self.userInteractionEnabled = true

    }
    

    func restart(){
        runAction(SKAction.sequence([
            SKAction.waitForDuration(NSTimeInterval(0.2)),
            
            SKAction.runBlock() {
                let scene = LevelOverScene(size: self.frame.size, won:true, currentLevel: 0)
                let reveal = SKTransition.fadeWithColor(scene.backgroundColor, duration: 1.1)
                (self.parent  as ColorGameScene).view?.presentScene(scene, transition:reveal)
            }
            ]))
    }
    
    func toMenu(){
        runAction(SKAction.sequence([
            SKAction.waitForDuration(NSTimeInterval(0.2)),
            
            SKAction.runBlock() {
                let scene = MainMenuScene(size: self.frame.size)
                let reveal = SKTransition.fadeWithColor(scene.backgroundColor, duration: 0.5)
                (self.parent  as ColorGameScene).view?.presentScene(scene, transition:reveal)
            }
            ]))
    }
    
    func fadeIn(){
        let fade = SKAction.fadeInWithDuration(0.2)
        self.runAction(fade)
    }
    
    func fadeOut(){
        let fade = SKAction.fadeOutWithDuration(0.2)
        self.runAction(fade)
}
    
    func update(){}
}

  