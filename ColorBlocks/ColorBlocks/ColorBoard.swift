//
//  ColorBoard.swift
//  ColorBlocks
//
//  Created by Tim on 2015-01-13.
//  Copyright (c) 2015 Tim. All rights reserved.
//
import SpriteKit

class ColorBoard: SKSpriteNode {
    var gameState = 0
    var winColor = UIColor(red: 1.0, green: 235/255, blue: 59/255, alpha: 1.0)
    var childrenDict:[Int:SKNode] = [:]
    var colorList:[UIColor] = []
    var winColorName = ""
    
    var activeChildren:[ColorBlock] = []
    
    var winAnimateAction = SKAction()
    var height:Int = 0
    var width:Int = 0
    var level = 0
    var blinkBuffer = [ColorBlock]()
    var blinkTimer = NSTimer()
    var readyToBlink = false
    
    convenience init(rectOfSize size: CGSize) {
        self.init()
        self.size = size
        self.color = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        self.userInteractionEnabled = true
        
        self.winAnimateAction = SKAction.colorizeWithColor(self.winColor, colorBlendFactor: 0.5, duration: 3.0)
        
        
    }
    
    override func addChild(node: SKNode) {
        if object_getClass(node).description() == "colorific.ColorBlock"{
            super.addChild(node)
            self.childrenDict[(node as ColorBlock).tagNum] = node
        }}
    
    
    func play(){
        self.showBlocks()
        
        self.defreeze()
        
        var parent = (self.parent as ColorGameScene)
        self.blinkTimer = NSTimer.scheduledTimerWithTimeInterval(parent.getInterval(), target: self, selector: Selector("bl"),  userInfo: nil, repeats: true)
        
    }
    
    func defreeze(){
        for block in self.children as [ColorBlock]{
            block.frozen = false
        }
    }
    
    func showBlocks(){
        var delay = 1
        for block in self.children as [ColorBlock]{
            block.appear(delay)
            //delay++
        }
    }
    
    func togglePause(){
        if !(self.paused) {
            self.blinkTimer = NSTimer.scheduledTimerWithTimeInterval((self.parent as ColorGameScene).getInterval(), target: self, selector: Selector("bl"),  userInfo: nil, repeats: true)
        }
        else {
            self.blinkTimer.invalidate()
        }
    }
    
    
    func update(){
        // 1 - victory, 2 - loss, 0 - game, 3 - paused
        
        var filteredChildren:[ColorBlock] = self.children as [ColorBlock]
        var win = filteredChildren.filter { $0.frozen == true  && $0.stopColor == self.winColor }
        var lost = filteredChildren.filter { $0.frozen == true  && $0.stopColor != self.winColor }
        readyToBlink = (filteredChildren.filter { $0.ready == true } == filteredChildren)
        
        
        self.activeChildren = filteredChildren.filter { $0.frozen == false }
        
        if !(self.paused){
            if self.children as [ColorBlock] == win as [ColorBlock] {
                self.gameState = 1
                
            }
            else if !(lost.isEmpty) {
                self.gameState = 2
                
            }
                
            else{
                self.gameState = 0
            }
        }
        else{
            self.readyToBlink = false
            self.gameState = 3
        }
        
        
    }
    
    func makeBlocks(level:Int){
        self.level = level
        //var blocks:[[ColorBlock]] = []
        
        var sides = getSides(level)
        
        var sideGap = CGFloat(48.0)
        var innerGap = CGFloat(24.0)
        var bottomGap = CGFloat(60.0)
        
        var boardWidth = self.size.width
        var boardHeight = self.size.height
        

        
        var blockWidth = CGFloat(boardWidth - sideGap*2 - innerGap*CGFloat(sides.0 - 1) ) / CGFloat(sides.0)
        var blockHeight = CGFloat(boardHeight  - bottomGap  - innerGap*CGFloat(sides.1 - 1)) / CGFloat(sides.1)
        
        //        if blockHeight > 1.44*blockWidth {
        //           blockHeight = 1.44*blockWidth
        //           bottomGap = 1.44*bottomGap
        //
        //        }
        
        
        
        
        var size = CGSize(width: blockWidth , height:  blockHeight)
        
        var tagNum = -1
        self.width = sides.0
        self.height = sides.1
        
        for var i=0; i < sides.0; i++ {
            
            var line:[ColorBlock] = []
            for var j=0; j < sides.1; j++ {
                var block = ColorBlock(rectOfSize: size)
                block.color = self.winColor
                
                
                block.position = CGPoint(x: block.size.width/2 + (CGFloat(i))*innerGap + CGFloat(i)*block.size.width + sideGap,
                    y: bottomGap +  block.size.height/2 + CGFloat(j)*block.size.height + (CGFloat(j))*innerGap)
                tagNum++
                
                
                block.tagNum = tagNum
                
                self.addChild(block)
                
                line.append(block)
                
            }
        }
        
        
        
    }
    
    
    
    func assign(){
        var listLen = self.width * self.height
        
        var totalColors = getShades(self.winColorName)
        
        
        while totalColors.count <= listLen {
            totalColors += getShades(self.winColorName)
        }
        var colors:[UIColor] = []
        
        for(var i = 0; i<listLen; i++){
            colors.append(totalColors[i])
            
        }
        
        
        self.colorList = colors
        
    }
    
    
    func bl(){
        var blinkColor = UIColor()
        
        self.assign()
        //var allColors = self.colorList
        var allColors = getShades(self.winColorName)
        
        
        
        
        
        var ind = 0
        
        
        var sessionColors = [UIColor]()
        
        var blockNum = self.activeChildren.count
        
        var  i = 0
        
        if (blockNum > 3){  i = (blockNum - 2) }
        else{  i = blockNum }
        
        
        allColors = sorted(allColors) {_, _ in arc4random() % 2 == 0}
        sessionColors = Array(allColors[0...i])
        sessionColors.append(self.winColor)
        
        for child in self.activeChildren
        {
            
            if sessionColors.count == 0 {
                
                allColors = sorted(allColors) {_, _ in arc4random() % 2 == 0}
                sessionColors = Array(allColors[0...i])
            }
            
            blinkColor = sessionColors[Int(arc4random_uniform(UInt32(sessionColors.count)))]
            
            var j = 0
            while (blinkColor == child.prevColor){
                if j > 4 {
                    allColors = sorted(allColors) {_, _ in arc4random() % 2 == 0}
                    blinkColor = allColors[Int(arc4random_uniform(UInt32(allColors.count)))] }
                else{
                    blinkColor = sessionColors[Int(arc4random_uniform(UInt32(sessionColors.count)))]
                }
                j++
            }
            
            if self.readyToBlink{
                child.blink(blinkColor)
            }
            
            if contains(sessionColors, blinkColor){
                ind = find(sessionColors, blinkColor)!
                sessionColors.removeAtIndex(ind)
            }
        }
    }
}




