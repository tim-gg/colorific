//
//  Button.swift
//  ColorBlocks
//
//  Created by Tim on 2015-01-29.
//  Copyright (c) 2015 Tim. All rights reserved.
//

import Foundation
import SpriteKit

class Button: SKSpriteNode {
    var duration = CGFloat()
    var mainColor = UIColor()
    
    convenience init(rectOfSize size: CGSize, duration: CGFloat) {
        self.init()
        self.size = size
        self.duration = duration
        self.color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        self.userInteractionEnabled = false
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var red:CGFloat = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat = 0.0
        
        self.mainColor = self.color
        self.color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        red -= 0.2
        green -= 0.2
        blue -= 0.2
        
        if red < 0.0 {red = 0.0}
        if green < 0.0 {red = 0.0}
        if blue < 0.0 {red = 0.0}
        
        
        var shadeColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        var colorizeAction = SKAction.colorizeWithColor(shadeColor, colorBlendFactor: 1.0, duration: 0.0)
        
        self.runAction(colorizeAction, withKey: "color")
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var colorizeBack = SKAction.colorizeWithColor(self.mainColor, colorBlendFactor: 1.0, duration: 0.0)
        self.runAction(colorizeBack)
    }




}