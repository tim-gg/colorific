//
//  ColorBlock.swift
//  ColorBlocks
//
//  Created by Tim on 2015-01-10.
//  Copyright (c) 2015 Tim. All rights reserved.
//
import SpriteKit


class ColorBlock: SKSpriteNode {
    var tagNum = 0
    var ready = false
    var frozen:Bool = true
    var stopColor = UIColor()
    var nextColor = UIColor()
    var appeared = false
    var prevColor = UIColor.redColor()
    
    
    //colors
    var colorList:[UIColor] = []
    


    
    convenience init(rectOfSize size: CGSize) {
        self.init()
        
        let cropNode = SKCropNode()
        let mask = SKShapeNode()
        
        
        
        mask.path = CGPathCreateWithRoundedRect(CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height), 3, 3, nil)
        cropNode.maskNode = mask
        cropNode.addChild(self)
        
        self.size = size
        
        self.color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        mask.strokeColor = self.color
        mask.fillColor = self.color
        
        self.userInteractionEnabled = true
        
    }
    
    override func touchesBegan(touches: (NSSet!), withEvent event: UIEvent) {
        
        if !(self.paused) && self.ready {
            
            
            self.freeze()
            
            
            var red:CGFloat = 0.0
            var green:CGFloat = 0.0
            var blue:CGFloat = 0.0
            
            self.color.getRed(&red, green: &green, blue: &blue, alpha: nil)
            
            red -= 0.2
            green -= 0.2
            blue -= 0.2
        
        var shadeColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        var colorizeAction = SKAction.colorizeWithColor(shadeColor, colorBlendFactor: 1.0, duration: 0.0)
        self.runAction(colorizeAction, withKey: "color")
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var colorizeBack = SKAction.colorizeWithColor(self.stopColor, colorBlendFactor: 1.0, duration: 0.0)
        self.runAction(colorizeBack)
        
    }
    
    func getInterval() -> NSTimeInterval{
        return (self.parent?.parent as ColorGameScene).getInterval()
    }
    
    
    func blink(blinkColor:UIColor){
        var changeColor = SKAction.colorizeWithColor(blinkColor, colorBlendFactor: 0.5, duration: 0.3)
        
        self.runAction(changeColor)
        
        self.nextColor = blinkColor
        self.prevColor = blinkColor
    }
    
    
    func appear(delay:Int){
        
        var size = self.size
        self.size = CGSize(width: 0,height: 0)
        
        var actX = SKAction.resizeToHeight(size.height, duration: 1.0)
        var actY = SKAction.resizeToWidth(size.width, duration: 1.0)
        
        //var act = SKAction.resizeToWidth(size.width, height: size.height, duration: 0.5)
        
        var h = 1.1*size.height
        var w = 1.1*size.width
        
        var step1 = SKAction.resizeToWidth(w, height: h, duration: 0.4)
        var step2 = SKAction.resizeToWidth(size.width, height: size.height, duration: 0.3)
        
        
        
        var getReady = SKAction.runBlock({
            self.ready = true
        })
        var wait = NSTimeInterval(0.2*CGFloat(delay))
        var act = SKAction.sequence([step1, step2])
        self.runAction(SKAction.sequence([SKAction.waitForDuration(wait), act, getReady]))
    }
    
    
    
    
    
    func freeze(){
        self.stopColor = self.nextColor
        self.frozen = true
    }
    
    
    
}