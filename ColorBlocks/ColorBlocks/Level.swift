//
//  Level.swift
//  ColorBlocks
//
//  Created by Tim on 2015-01-18.
//  Copyright (c) 2015 Tim. All rights reserved.
//

import SpriteKit

class Level: NSObject {
    var background = SKSpriteNode()
    var blockboard = ColorBoard()
    
     init(levelNum:Int){
        var blocks:[[ColorBlock]] = []
            
            var sides = getSides(levelNum)
        
            for var i=0; i < sides.0; i++ {
                var line:[ColorBlock] = []
                for var j=0; j < sides.1; j++ {
                    var size = CGSize(width: blockboard.size.width / CGFloat(sides.0), height: blockboard.size.height / CGFloat(sides.1))
                    
                    
                    
                    var block = ColorBlock(rectOfSize: size)
                    //block.anchorPoint = CGPoint(x: 0, y: 0)
                    
                    
                    block.position = CGPoint(x:  -blockboard.frame.maxX/2 + block.size.width/2 + CGFloat(i) * (block.size.width), y:  -blockboard.frame.maxY/2 + block.size.height/2 + CGFloat(j) * (block.size.height))
                    
                    
                    blockboard.addChild(block)
                    
                    line.append(block)
                    
                }
                blocks.append(line)
            }

    }

}
