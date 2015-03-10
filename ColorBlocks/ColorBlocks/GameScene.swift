//
//  GameScene.swift
//  colorific
//
//  Created by Tim on 2014-12-30.
//  Copyright (c) 2014 Tim. All rights reserved.
//

import SpriteKit
//import GameFunctions

class ColorGameScene: SKScene {
    var background = SKSpriteNode()
    var blockboard = ColorBoard()
    var pauseButton = Button()
    var levelLabel = SKLabelNode()
    var pauseWindow = PauseWindow()
    var gameOverWindow = GameOverWindow()
    var gameState = 0
    var currentLevel = 0
    var secondsPlayed = CGFloat(0.0)
    var blocksNum = 0
    let defaults = NSUserDefaults()
    var effect = SKEffectNode()
    var layer = SKSpriteNode()
    var winColor = UIColor()
    var winColorName = ""
    
    
    override func didMoveToView(view: SKView) {
        self.winColorName = NSUserDefaults().stringForKey("winColor")!
        self.winColor = colorMap[self.winColorName]!
        
        self.size = CGSize(width: 640, height:1136)
        self.scaleMode = .ResizeFill
        
        //background
        background.color = UIColor(red: 0.094, green: 0.176, blue: 0.259, alpha:1.0)
        background.size = self.frame.size
        background.position = CGPoint(x: CGRectGetMidX(self.frame) , y:CGRectGetMidY(self.frame))
        self.addChild(background)
        
        //pause button
        pauseButton = Button(rectOfSize: CGSize(width: 60, height: 60), duration: 0.0)
        pauseButton.color = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        pauseButton.position = CGPoint(x:CGRectGetMaxX(self.frame)-70, y:CGRectGetMaxY(self.frame)-75);
        pauseButton.name = "pause"
        
        var pauseIcon = SKSpriteNode(imageNamed: "pause")
        pauseIcon.name = "pause"
        pauseIcon.color = UIColor.yellowColor()
        
        pauseButton.addChild(pauseIcon)
        self.addChild(pauseButton)
        
        
        // LEVEL INDICATOR
        levelLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        levelLabel.text = "\(self.currentLevel + 1)"
        levelLabel.fontSize = 80
        levelLabel.fontColor = UIColor.yellowColor()
        levelLabel.verticalAlignmentMode = .Center
        levelLabel.horizontalAlignmentMode = .Center
        levelLabel.position.x = CGRectGetMinX(self.frame) + 60
        levelLabel.position.y = CGRectGetMaxY(self.frame) - 80
        self.addChild(levelLabel)
        
        // COLOR INDICATOR
        var colorLabel = SKLabelNode(fontNamed: "AlegreyaSansSC-Light")
        colorLabel.text = "\(self.winColorName)".uppercaseString
        colorLabel.fontSize = 50
        colorLabel.fontColor = self.winColor
        colorLabel.verticalAlignmentMode = .Center
        colorLabel.horizontalAlignmentMode = .Center
        colorLabel.position.x = CGRectGetMinX(self.frame) + 320
        colorLabel.position.y = CGRectGetMaxY(self.frame) - 145
        addChild(colorLabel)
        
        //blockboard
        let upperGap:CGFloat = 130.0
        let boardSize = CGSize(width: self.frame.width, height: self.frame.height - 230)
        
        blockboard = ColorBoard(rectOfSize: boardSize)
        blockboard.color = self.background.color
        blockboard.position = CGPoint(x:0, y:0)
        blockboard.anchorPoint = CGPoint(x:0,y:0)
        blockboard.winColor = self.winColor
        blockboard.winColorName = self.winColorName
        self.addChild(blockboard)
        
        
        // pause window
        pauseWindow = PauseWindow(rectOfSize: self.frame.size)
        pauseWindow.position = CGPoint(x: CGRectGetMidX(self.frame) , y:CGRectGetMidY(self.frame))
        self.pauseWindow.name = "pauseWindow"
        (pauseWindow as SKNode).zPosition = 3.0
        
        
        //game over window
        gameOverWindow = GameOverWindow(rectOfSize: self.frame.size)
        gameOverWindow.name = "gameOver"
        gameOverWindow.position = CGPoint(x: CGRectGetMidX(self.frame) , y:CGRectGetMidY(self.frame))
        (gameOverWindow as SKNode).zPosition = 3.0
        
        
        // TIMER
        var timer = NSTimer.scheduledTimerWithTimeInterval( 1.0, target: self, selector: Selector("increaseTime"), userInfo: nil, repeats: true)
        
        self.nextLevel()
        
        
        // NOTIFICATIONS
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("pauseGame"), name: "pauseScene", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("callBreak"), name: "break", object: nil)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location: CGPoint! = touch.locationInNode(self)
            
            let nodeAtPoint = self.nodeAtPoint(location)
            
            if (nodeAtPoint.name == "pause") {
                self.pauseGame()
            }
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.blockboard.update()
        self.gameState = blockboard.gameState
        
        if self.gameState == 1 {
            
            if self.secondsPlayed <= CGFloat(self.blocksNum) + CGFloat(1.0) {
                self.addBonus()
                //println("       BONUS  BONUS   BONUS    BONUS   BONUS      BONUS       ")
            }
            
            let winAction = SKAction.runBlock() {
                let nextLevelScene = LevelOverScene(size: self.size, won: true, currentLevel:self.currentLevel)
                nextLevelScene.backgroundColor = self.blockboard.winColor
                let reveal = SKTransition.fadeWithColor(self.blockboard.winColor, duration: 1.1)
                self.view?.presentScene(nextLevelScene, transition: reveal)
            }
            
            let lastLevelAction = SKAction.runBlock() {
                let menuScene = MainMenuScene(size: self.size)
                let menuReveal = SKTransition.fadeWithColor(menuScene.backgroundColor, duration: 0.5)
                self.view?.presentScene(menuScene, transition:menuReveal)
            }
            
            if self.currentLevel < 59 {
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), winAction]))
            } else {
                self.runAction(lastLevelAction)
            }
        }
        
        if self.gameState == 2 {
            self.blockboard.paused = true
            self.blockboard.togglePause()
            self.gameOver()
        }
    }

    
    func nextLevel(){
        self.currentLevel++
        self.blockboard.gameState = 0
        self.blocksNum = findBlocksNum(self.currentLevel)
        self.blockboard.removeAllChildren()
        self.blockboard.makeBlocks(blocksNum)
        self.blockboard.play()
    }
    
    
    // ASSIGN SCORE TO CORE DATA
    func assignScore(){
        var highscore = self.defaults.integerForKey("highscore")
        var lastscore = self.defaults.integerForKey("lastscore")
        
        var score = self.currentLevel - 1
        self.gameOverWindow.addLevelIndicator(score)
        
        if (score > highscore)
        {
            self.defaults.setInteger(score, forKey: "highscore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        saveHighscore(score)
        NSNotificationCenter.defaultCenter().postNotificationName("gameCenter", object: self)
        
        
        self.defaults.setInteger(score, forKey: "lastscore")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
    }
    
    
    // PAUSE/END GAME
    func callBreak(){
        self.blockboard.paused = true
    }
    
    func pauseGame()
    {
        if self.blockboard.paused == true {
            self.blockboard.paused = false
            self.blockboard.togglePause()
            
            self.runAction(SKAction.sequence([SKAction.runBlock({
                self.pauseWindow.fadeOut()
            }), SKAction.waitForDuration(0.2) , SKAction.runBlock({
                
                self.removeChildrenInArray([self.pauseWindow])
            })]))
        }
        else{
            self.blockboard.paused = true
            self.blockboard.togglePause()
            self.addChild(self.pauseWindow)
            
            self.pauseWindow.fadeIn()
        }
    }
    
    func gameOver(){
        self.assignScore()
        self.addChild(self.gameOverWindow)
        self.gameOverWindow.fadeIn()
        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.runBlock({
            
        })]))
    }
    /////////////////////////////////////////////
    
    func getInterval() -> NSTimeInterval{
        var level = self.currentLevel
        
        var mod = level%4 as Int
        
        
        
        var interval = CGFloat(1.0 - CGFloat(mod)*0.15)
        
        if interval <= CGFloat(0.05) {
            interval = CGFloat(0.05)
        }
        
        return NSTimeInterval(interval)
    }
    
    
    // BONUS
    func increaseTime(){
        self.secondsPlayed++
    }
    
    func addBonus(){
        var bonus = self.defaults.integerForKey("bonus")
        bonus++
        
        self.defaults.setInteger(bonus, forKey: "bonus")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func resetBonus(){
        self.defaults.setInteger(0, forKey: "bonus")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
