//
//  GameOverScene.swift
//  ColorBlocks
//
//  Created by Tim on 2015-01-29.
//  Copyright (c) 2015 Tim. All rights reserved.
//

import Foundation
import SpriteKit

class LevelOverScene: SKScene {
    
    
    init(size: CGSize, won:Bool, currentLevel:Int) {
        
        super.init(size: size)
        
        // 1
        self.backgroundColor = won ? UIColor(red: 136/255, green: 213/255, blue: 222/255, alpha: 1.0) : SKColor.whiteColor()
        
        // 2
        var color: String =  NSUserDefaults().stringForKey("winColor")!
        var message: String = ""
        var message2 = ""
        
        var str = ""
        var str2  = ""
        if countElements(color) > 6 {
        str  = "TAP THE"
        str2  = "\(color)!".uppercaseString
        }
        else {
        str  = "TAP THE \(color)!".uppercaseString
        
        }
        
        message = (currentLevel != 0) ? "AWESOME!" : str
        
        
        // 3
        let label = SKLabelNode(fontNamed: "AlegreyaSansSC-Thin")
        let label2 = SKLabelNode(fontNamed: "AlegreyaSansSC-Thin")
        label.text = message
        label.fontSize = 88
        label.fontColor = SKColor.blackColor()
        label.alpha = 0.0
        
        if (str2 != "") && (currentLevel == 0) {
            
            label2.text = str2
            label2.fontSize = 88
            label2.fontColor = SKColor.blackColor()
            label2.alpha = 0.0
            label2.position = CGPoint(x: size.width/2, y: size.height/2 + 180)
            label.position = CGPoint(x: size.width/2, y: size.height/2 + 300)
            addChild(label2)
        }
        else{
        label.position = CGPoint(x: size.width/2, y: size.height/2 + 200)
        }
        addChild(label)
        
        
        var nextLevel = SKSpriteNode()
        nextLevel.size = CGSize(width: 540, height: 275)
        
        var nextX = CGRectGetMaxX(self.frame) - nextLevel.size.width/2 - 48
        var nextY = CGRectGetMaxY(self.frame) - nextLevel.size.height/2 - 570
        nextLevel.position = CGPoint(x: nextX, y: nextY)
        nextLevel.color = UIColor(red: 143/255, green: 117/255, blue: 179/255, alpha: 1.0)
        nextLevel.alpha = 0.0
        
        
        let nextLevelLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Thin")
        nextLevelLabel.text = "level \(currentLevel + 1)"
        
        if currentLevel + 1 < 10{
        nextLevelLabel.fontSize = 200
        } else{
        nextLevelLabel.fontSize = 175
        }
        nextLevelLabel.verticalAlignmentMode = .Center
        nextLevelLabel.horizontalAlignmentMode = .Center
        
        
        
        nextLevel.addChild(nextLevelLabel)
        self.addChild(nextLevel)
        
        
        
        let revealLabel = SKAction.fadeInWithDuration(1.0)
        nextLevel.runAction(revealLabel)
        label.runAction(revealLabel)
        if str2 != "" { label2.runAction(revealLabel) }
        
        
        
        
        
        
        // 5
        runAction(SKAction.sequence([
            SKAction.waitForDuration(5.0),
            SKAction.runBlock() {
                // 5
                
                if won{
                let scene = ColorGameScene(size: size)
                let reveal = SKTransition.fadeWithColor(scene.backgroundColor, duration: 0.6)
                scene.currentLevel = currentLevel
                self.view?.presentScene(scene, transition:reveal)
                }
                else{
                    let scene = MainMenuScene(size: size)
                    let reveal = SKTransition.fadeWithColor(scene.backgroundColor, duration: 0.5)
                    self.view?.presentScene(scene, transition:reveal)
                }
                
                
            }
            ]))
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
