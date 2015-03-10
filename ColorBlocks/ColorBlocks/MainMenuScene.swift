//
//  MenuScene.swift
//  ColorBlocks
//
//  Created by Tim on 2015-01-29.
//  Copyright (c) 2015 Tim. All rights reserved.
//

import Foundation
import SpriteKit
import Social


class MainMenuScene: SKScene {
    var background = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        self.size = CGSize(width: 640, height:1136)
        assignWinColor()
        
        // BACKGROUND
        background.color = UIColor(red: 136/255, green: 213/255, blue: 222/255, alpha: 1.0)
        background.size = self.frame.size
        background.position = CGPoint(x: CGRectGetMidX(self.frame) , y:CGRectGetMidY(self.frame))
        self.addChild(background)
        
        
        // TITLE LABEL
        let titleLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Thin")
        titleLabel.text = "colorific"
        titleLabel.fontSize = 100
        titleLabel.fontColor = SKColor.blackColor()
        titleLabel.verticalAlignmentMode = .Center
        titleLabel.horizontalAlignmentMode = .Center
        
        titleLabel.position.x = CGRectGetMidX(self.frame)
        titleLabel.position.y = CGRectGetMaxY(self.frame) - titleLabel.frame.size.height - 175
        addChild(titleLabel)
        
        
        // START BUTTON
        var startButton = Button(rectOfSize: CGSize(width: 230, height: 230), duration: 4.0)
        startButton.color = UIColor(red: 142/255, green: 186/255, blue: 77/255, alpha: 1.0)
        var butX = startButton.size.width/2 + 65.0
        var butY = startButton.size.width/2 + 539.0
        startButton.position = CGPoint(x:butX, y:butY)
        startButton.name = "start"
        
        let playLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        playLabel.text = "PLAY"
        playLabel.name = "startL"
        playLabel.fontSize = 72
        playLabel.fontColor = SKColor.whiteColor()
        playLabel.verticalAlignmentMode = .Center
        playLabel.horizontalAlignmentMode = .Center
        playLabel.position.y += 30
        startButton.addChild(playLabel)
        
        let playIcon = SKSpriteNode(imageNamed: "play")
        playIcon.position.y -= 51.0
        playIcon.color = UIColor.whiteColor()
        playIcon.name = "startI"
        
        
        startButton.addChild(playIcon)
        self.addChild(startButton)
        
        
        // SETTINGS BUTTON
        var settingsButton = Button(rectOfSize: CGSize(width: 230, height: 230), duration: 4.0)
        settingsButton.color = UIColor(red: 250/255, green: 116/255, blue: 112/255, alpha: 1.0)
        var setX = settingsButton.size.width/2 + 345.0
        var setY = settingsButton.size.width/2 + 539.0
        settingsButton.position = CGPoint(x:setX, y:setY)
        settingsButton.name = "settings"
        
        let setLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        setLabel.text = "SCORES"
        setLabel.fontSize = 50
        setLabel.verticalAlignmentMode = .Center
        setLabel.horizontalAlignmentMode = .Center
        setLabel.position.y += 30
        setLabel.name = "setL"
        
        let setIcon = SKSpriteNode(imageNamed: "trophy")
        setIcon.position.y -= 51.0
        setIcon.name = "setI"
        
        
        settingsButton.addChild(setIcon)
        settingsButton.addChild(setLabel)
        self.addChild(settingsButton)
        
        
        // SCORE LABEL
        var scoreColor = UIColor(red: 1.0, green: 1.0, blue: 191/255, alpha: 1.0)
        var highScore = NSUserDefaults().integerForKey("highscore")
        
        let highScoreLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        highScoreLabel.text = "high score"
        highScoreLabel.fontSize = 50
        highScoreLabel.fontColor = SKColor.whiteColor()
        highScoreLabel.verticalAlignmentMode = .Center
        highScoreLabel.horizontalAlignmentMode = .Center
        highScoreLabel.fontColor = scoreColor
        
        highScoreLabel.position.x = CGRectGetMidX(self.frame)
        highScoreLabel.position.y = CGRectGetMaxY(self.frame) - highScoreLabel.frame.size.height - 645
        self.addChild(highScoreLabel)
        
        let highScoreInd = SKLabelNode(fontNamed: "AlegreyaSansSC-Bold")
        highScoreInd.text = " \(highScore)"
        highScoreInd.fontSize = 55
        highScoreInd.fontColor = SKColor.whiteColor()
        highScoreInd.verticalAlignmentMode = .Center
        highScoreInd.horizontalAlignmentMode = .Center
        highScoreInd.position.x = CGRectGetMidX(self.frame)
        highScoreInd.position.y = CGRectGetMaxY(self.frame) - highScoreLabel.frame.size.height - 695
        highScoreInd.fontColor = scoreColor
        self.addChild(highScoreInd)
        
        var lastScore = NSUserDefaults().integerForKey("lastscore")
        let lastScoreLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        
        lastScoreLabel.text = "last score"
        lastScoreLabel.fontSize = 50
        lastScoreLabel.fontColor = SKColor.whiteColor()
        lastScoreLabel.verticalAlignmentMode = .Center
        lastScoreLabel.horizontalAlignmentMode = .Center
        lastScoreLabel.position.x = CGRectGetMidX(self.frame)
        lastScoreLabel.position.y = CGRectGetMaxY(self.frame) - highScoreLabel.frame.size.height - 760
        lastScoreLabel.fontColor = scoreColor
        self.addChild(lastScoreLabel)
        
        let lastScoreInd = SKLabelNode(fontNamed: "AlegreyaSansSC-Bold")
        lastScoreInd.text = " \(lastScore)"
        lastScoreInd.fontSize = 55
        lastScoreInd.fontColor = SKColor.whiteColor()
        lastScoreInd.verticalAlignmentMode = .Center
        lastScoreInd.horizontalAlignmentMode = .Center
        lastScoreInd.position.x = CGRectGetMidX(self.frame)
        lastScoreInd.position.y = CGRectGetMaxY(self.frame) - highScoreLabel.frame.size.height - 810
        lastScoreInd.fontColor = scoreColor
        self.addChild(lastScoreInd)
        
        
        // SOCIAL SHARING
        var facebookButton = Button(rectOfSize: CGSize(width: 60, height: 60), duration: 4.0)
        facebookButton.color = UIColor(red: 142/255, green: 186/255, blue: 77/255, alpha: 0.0)
        var fbX = CGRectGetMidX(self.frame) - 60
        var fbY = CGFloat(142)
        facebookButton.position = CGPoint(x:fbX, y:fbY)
        facebookButton.name = "fb"
        
        let fbIcon = SKSpriteNode(imageNamed: "fb")
        fbIcon.name = "fb"
        
        facebookButton.addChild(fbIcon)
        self.addChild(facebookButton)
        
        var twitterButton = Button(rectOfSize: CGSize(width: 60, height: 60), duration: 4.0)
        twitterButton.color = UIColor(red: 142/255, green: 186/255, blue: 77/255, alpha: 0.0)
        var twX = CGRectGetMidX(self.frame) + 60
        var twY = CGFloat(142)
        twitterButton.position = CGPoint(x:twX, y:twY)
        twitterButton.name = "tw"
        
        let twIcon = SKSpriteNode(imageNamed: "tw")
        twIcon.name = "tw"
        
        
        twitterButton.addChild(twIcon)
        self.addChild(twitterButton)
    }
    
    func start(){
        runAction(SKAction.sequence([
            SKAction.waitForDuration(NSTimeInterval(0.2)),
            
            SKAction.runBlock() {
                let scene = LevelOverScene(size: self.frame.size, won:true, currentLevel: 0)
                let reveal = SKTransition.fadeWithColor(scene.backgroundColor, duration: 1.1)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location: CGPoint! = touch.locationInNode(self)
            let nodeAtPoint = self.nodeAtPoint(location)
            
            if (nodeAtPoint.name == "start") || (nodeAtPoint.name == "startL") || (nodeAtPoint.name == "startI"){
                self.childNodeWithName("start")?.touchesBegan(touches, withEvent: event)
                self.start()
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
            else if (nodeAtPoint.name == "settings") || (nodeAtPoint.name == "setL") || (nodeAtPoint.name == "setI"){
                self.childNodeWithName("settings")?.touchesBegan(touches, withEvent: event)
                
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.runBlock({
                    NSNotificationCenter.defaultCenter().postNotificationName("logIn", object: self)
                    NSNotificationCenter.defaultCenter().postNotificationName("gameCenter", object: self)
                    self.childNodeWithName("settings")?.touchesEnded(touches, withEvent: event)
                })]))
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location: CGPoint! = touch.locationInNode(self)
            let nodeAtPoint = self.nodeAtPoint(location)
            
            if (nodeAtPoint.name == "start") || (nodeAtPoint.name == "startL") || (nodeAtPoint.name == "startI"){
                self.childNodeWithName("start")?.touchesEnded(touches, withEvent: event)
            }
            else if (nodeAtPoint.name == "settings") || (nodeAtPoint.name == "setL") || (nodeAtPoint.name == "setI"){
                self.childNodeWithName("settings")?.touchesEnded(touches, withEvent: event)
            }
        }
    }
    
    func assignWinColor(){
        var color = getWinColor()
        
        NSUserDefaults().setObject(color, forKey: "winColor")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func update(currentTime: CFTimeInterval) {}
    
}



