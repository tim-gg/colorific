//
//  PauseWindow.swift
//  ColorBlocks
//
//  Created by Tim on 2015-01-30.
//  Copyright (c) 2015 Tim. All rights reserved.
//

import Foundation
import SpriteKit

class PauseWindow: GameBreakWindow {
    var resumeButton = Button()
    var mMenuButton = Button()
    var restartButton = Button()
    
    convenience init(rectOfSize size: CGSize) {
        self.init()
        self.size = size
        self.color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        self.alpha = 0.0
        self.userInteractionEnabled = true
        
        // VISUAL EFFECTS
        /*        var effect = SKEffectNode()
        
                var filter = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 30.0])
                effect.filter = filter
        
        
                self.addChild(effect)
        
                effect.zPosition = 0.0 */
        
        
        // BACKGROUND
        var bg = SKSpriteNode()
        bg.size = self.size
        bg.color = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        bg.alpha = 0.8
        
        self.addChild(bg)
        
        
        // RESUME BUTTON
        resumeButton = Button(rectOfSize: CGSize(width: 544, height: 195), duration: 0.0)
        var resX = CGRectGetMinX(self.frame) + resumeButton.size.width/2 + 48
        var resY = CGRectGetMaxY(self.frame) - resumeButton.size.height/2 - 265
        resumeButton.position = CGPoint(x:resX, y:resY)
        resumeButton.name = "resume"
        resumeButton.color = UIColor(red: 0.0, green: 179/255, blue: 54/255, alpha: 1.0)
        
        let resumeLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        resumeLabel.text = "RESUME"
        resumeLabel.fontSize = 80
        resumeLabel.verticalAlignmentMode = .Center
        resumeLabel.horizontalAlignmentMode = .Center
        resumeLabel.name = "resL"
        
        resumeButton.addChild(resumeLabel)
        resumeButton.zPosition = 1
        self.addChild(resumeButton)
        
        
        // MENU BUTTON
        mMenuButton = Button(rectOfSize: CGSize(width: 230, height: 230), duration: 0.0)
        var menuX = CGRectGetMaxX(self.frame) - mMenuButton.size.width/2 - 60
        var menuY = CGRectGetMaxY(self.frame) - mMenuButton.size.height/2 - 540
        mMenuButton.position = CGPoint(x:menuX, y:menuY)
        mMenuButton.name = "menu"
        mMenuButton.color = UIColor(red: 101/255, green: 181/255, blue: 207/255, alpha: 1.0)
        
        let menuLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        menuLabel.text = "MENU"
        menuLabel.fontSize = 72
        menuLabel.verticalAlignmentMode = .Center
        menuLabel.horizontalAlignmentMode = .Center
        menuLabel.name = "menuL"
        
        mMenuButton.addChild(menuLabel)
        mMenuButton.zPosition = 1
        self.addChild(mMenuButton)
        
        // RESTART BUTTON
        restartButton = Button(rectOfSize: CGSize(width: 230, height: 230), duration: 0.0)
        var restX = CGRectGetMinX(self.frame) + restartButton.size.width/2 + 60
        var restY = CGRectGetMaxY(self.frame) - restartButton.size.height/2 - 540
        restartButton.position = CGPoint(x: restX, y: restY);
        restartButton.name = "restart"
        restartButton.color = UIColor(red: 205/255, green: 219/255, blue: 3/255, alpha: 1.0)
        
        let restartLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        restartLabel.text = "RESTART"
        restartLabel.fontSize = 64
        restartLabel.verticalAlignmentMode = .Center
        restartLabel.horizontalAlignmentMode = .Center
        restartLabel.name = "restartL"
        
        restartButton.addChild(restartLabel)
        restartButton.zPosition = 1
        self.addChild(restartButton)
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location: CGPoint! = touch.locationInNode(self)
            let nodeAtPoint = self.nodeAtPoint(location)
            
            if (nodeAtPoint.name == "resume") || (nodeAtPoint.name == "resL"){
                self.childNodeWithName("resume")?.touchesBegan(touches, withEvent: event)
                self.resumeGame()
            }
                
            else if (nodeAtPoint.name == "menu") || (nodeAtPoint.name == "menuL") {
                self.childNodeWithName("menu")?.touchesBegan(touches, withEvent: event)
                self.toMenu()
            }
                
            else if (nodeAtPoint.name == "restart") || (nodeAtPoint.name == "restartL"){
                self.childNodeWithName("restart")?.touchesBegan(touches, withEvent: event)
                self.restart()
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location: CGPoint! = touch.locationInNode(self)
            let nodeAtPoint = self.nodeAtPoint(location)
            
            if (nodeAtPoint.name == "resume") || (nodeAtPoint.name == "resL"){
                self.childNodeWithName("resume")?.touchesEnded(touches, withEvent: event)
            }
                
            else if (nodeAtPoint.name == "menu") || (nodeAtPoint.name == "menuL") {
                self.childNodeWithName("menu")?.touchesEnded(touches, withEvent: event)
            }
                
            else if (nodeAtPoint.name == "restart") || (nodeAtPoint.name == "restartL"){
                self.childNodeWithName("restart")?.touchesEnded(touches, withEvent: event)
            }
        }
    }
    
    func resumeGame(){
        let action = SKAction.runBlock({
            (self.parent as ColorGameScene).blockboard.paused = true
            (self.parent as ColorGameScene).pauseGame()
        })
        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.2), action]))
    }
}
