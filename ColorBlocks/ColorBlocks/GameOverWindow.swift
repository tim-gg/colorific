//
//  GameOverWindow.swift
//  ColorBlocks
//
//  Created by Tim on 2015-02-02.
//  Copyright (c) 2015 Tim. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverWindow: GameBreakWindow {
    var mMenuButton = Button()
    var restartButton = Button()
    
    
    convenience init(rectOfSize size: CGSize) {
        self.init()
        self.size = size
        self.color = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        self.alpha = 0.0
        
        
        self.userInteractionEnabled = true
        
        


        // GAME OVER LABEL
        var gameOver = SKSpriteNode()
        gameOver.size = CGSize(width: 400, height: 400)
        var gameOverX = CGRectGetMaxX(self.frame) - gameOver.size.width/2 - 120
        var gameOverY = CGRectGetMaxY(self.frame) - gameOver.size.height/2 - 88
        gameOver.position = CGPoint(x:gameOverX, y:gameOverY)
        gameOver.color = UIColor(red: 136/255, green: 213/255, blue: 222/255, alpha: 1.0)
        
        let gameOverLabel1 = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        gameOverLabel1.text = "OVER"
        gameOverLabel1.fontSize = 100
        gameOverLabel1.verticalAlignmentMode = .Center
        gameOverLabel1.horizontalAlignmentMode = .Center
        
        gameOverLabel1.position.y -= 70
        
        let gameOverLabel2 = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        gameOverLabel2.text = "GAME"
        gameOverLabel2.fontSize = 100
        gameOverLabel2.verticalAlignmentMode = .Center
        gameOverLabel2.horizontalAlignmentMode = .Center
        gameOverLabel2.position.y += 70
        
        gameOver.addChild(gameOverLabel1)
        gameOver.addChild(gameOverLabel2)
        self.addChild(gameOver)
        
        
        // MENU BUTTON
        mMenuButton = Button(rectOfSize: CGSize(width: 230, height: 230), duration: 0.0)
        var menuX = CGRectGetMaxX(self.frame) - mMenuButton.size.width/2 - 60
        var menuY = CGRectGetMaxY(self.frame) - mMenuButton.size.height/2 - 540
        mMenuButton.position = CGPoint(x:menuX, y:menuY)
        mMenuButton.name = "menu"
        mMenuButton.color = UIColor(red: 151/255, green: 118/255, blue: 191/255, alpha: 1.0)
        
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
        restartButton.color = UIColor(red: 214/255, green: 102/255, blue: 94/255, alpha: 1.0)
        
        let restartLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        restartLabel.text = "RESTART"
        restartLabel.fontSize = 64
        restartLabel.verticalAlignmentMode = .Center
        restartLabel.horizontalAlignmentMode = .Center
        restartLabel.name = "restartL"
        
        restartButton.addChild(restartLabel)
        restartButton.zPosition = 1
        self.addChild(restartButton)
        

        
        
        // SOCIAL SHARING
        var facebookButton = Button(rectOfSize: CGSize(width: 60, height: 60), duration: 4.0)
        facebookButton.color = UIColor(red: 142/255, green: 186/255, blue: 77/255, alpha: 0.0)
        var fbX = CGRectGetMidX(self.frame) - 95
        var fbY = CGRectGetMinY(self.frame) + CGFloat(120)
        facebookButton.position = CGPoint(x:fbX, y:fbY)
        facebookButton.name = "fb"
        
        let fbIcon = SKSpriteNode(imageNamed: "fb")
        fbIcon.name = "fb"
        
        
        facebookButton.addChild(fbIcon)
        self.addChild(facebookButton)
        
        var twitterButton = Button(rectOfSize: CGSize(width: 60, height: 60), duration: 4.0)
        twitterButton.color = UIColor(red: 142/255, green: 186/255, blue: 77/255, alpha: 0.0)
        var twX = CGRectGetMidX(self.frame) + 95
        var twY = CGRectGetMinY(self.frame) + CGFloat(120)
        twitterButton.position = CGPoint(x:twX, y:twY)
        twitterButton.name = "tw"
        
        let twIcon = SKSpriteNode(imageNamed: "tw")
        twIcon.name = "tw"
        
        
        twitterButton.addChild(twIcon)
        self.addChild(twitterButton)
        
        var trophyButton = Button(rectOfSize: CGSize(width: 60, height: 60), duration: 4.0)
        trophyButton.color = UIColor(red: 142/255, green: 186/255, blue: 77/255, alpha: 0.0)
        var trX = CGRectGetMidX(self.frame)
        var trY = CGRectGetMinY(self.frame) + CGFloat(120)
        trophyButton.position = CGPoint(x:trX, y:trY)
        trophyButton.name = "tr"
        
        let trIcon = SKSpriteNode(imageNamed: "trophy")
        trIcon.name = "tr"
        
        
        trophyButton.addChild(trIcon)
        self.addChild(trophyButton)
        
        
        ///////////////////////////

        
        
        
    }
    func addLevelIndicator(score: Int){
        var level = score
        
        
        var levelLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        levelLabel.text = "\(level)"
        levelLabel.fontSize = 80
        levelLabel.fontColor = UIColor.yellowColor()
        levelLabel.verticalAlignmentMode = .Center
        levelLabel.horizontalAlignmentMode = .Center
        levelLabel.position.y = -280
        self.addChild(levelLabel)
        
        var highScore = NSUserDefaults().integerForKey("highcore")
        
        
        var newHighLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        newHighLabel.text = "new highscore!"
        newHighLabel.fontSize = 80
        newHighLabel.fontColor = UIColor.yellowColor()
        newHighLabel.verticalAlignmentMode = .Center
        newHighLabel.horizontalAlignmentMode = .Center
        newHighLabel.position.y = -340
        
        
        if level > highScore {
            self.addChild(newHighLabel)
            
        }
    
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            let location: CGPoint! = touch.locationInNode(self)
            
            let nodeAtPoint = self.nodeAtPoint(location)
            


            if (nodeAtPoint.name == "menu") || (nodeAtPoint.name == "menuL") {
                self.childNodeWithName("menu")?.touchesBegan(touches, withEvent: event)
                self.toMenu()
            }
                
            else if (nodeAtPoint.name == "restart") || (nodeAtPoint.name == "restartL") {
                
                self.childNodeWithName("restart")?.touchesBegan(touches, withEvent: event)
                
                
                
                
                    
                self.restart()
            }

            else if (nodeAtPoint.name == "fb") {
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.runBlock({
                    NSNotificationCenter.defaultCenter().postNotificationName("post", object: self)
                })]))
                
            }
            else if (nodeAtPoint.name == "tw") {
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.runBlock({
                    NSNotificationCenter.defaultCenter().postNotificationName("tweet", object: self)
                })]))
                
            }
            else if (nodeAtPoint.name == "tr") {
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.runBlock({
                    NSNotificationCenter.defaultCenter().postNotificationName("logIn", object: self)
                    NSNotificationCenter.defaultCenter().postNotificationName("gameCenter", object: self)
                    nodeAtPoint.touchesEnded(touches, withEvent: event)
                })]))
                
            }
            

            
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location: CGPoint! = touch.locationInNode(self)
            
            let nodeAtPoint = self.nodeAtPoint(location)
            
            if (nodeAtPoint.name == "menu") || (nodeAtPoint.name == "menuL"){
                self.childNodeWithName("menu")?.touchesEnded(touches, withEvent: event)}
                
            else if (nodeAtPoint.name == "restart") || (nodeAtPoint.name == "restartL"){
                self.childNodeWithName("restart")?.touchesEnded(touches, withEvent: event)}
            
            
        }
    }

}