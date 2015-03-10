//  GameFunctions.swift
//  colorific
//
//  Created by Tim on 2015-01-11.
//  Copyright (c) 2015 Tim. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

// PARAMETERS
var winColorList:[String] = ["red", "green", "yellow", "turquoise"]

var colorMap = [ "green" : UIColor(red: 0.0, green: 184/255, blue: 64/255, alpha: 1.0),
    "red" : UIColor(red: 1.0, green: 61/255, blue: 61/255, alpha: 1.0), "yellow": UIColor(red: 1.0, green: 235/255, blue: 59/255, alpha: 1.0), "turquoise" : UIColor(red: 0/255, green: 232/255, blue: 220/255, alpha: 1.0),"purple" : UIColor(red: 113/255, green: 36/255, blue: 214/255, alpha: 1.0), "pink" : UIColor(red: 196/255, green: 24/255, blue: 84/255, alpha: 1.0)]


var winColor = UIColor()
func getShades(shade:String) -> [UIColor] {
    
    var redShades = [(230 , 15, 0), (189, 70, 56), (255, 178, 186), (255, 129, 115)]
    var blueShades = [(79, 205, 227),(101, 176, 252), (26, 122, 217), (43, 86, 171), (13, 65, 163),(27, 154, 250)]
    var turqShades = [(86, 220, 227),(0, 97, 102), (78, 186, 186), (179, 224, 222)]
    var greenShades = [(12, 51, 30), (40, 130, 40), (114, 224, 153), (182, 252, 217), (165, 224, 56),(217, 255, 0), (179, 255, 0), (0,191,70)]
    var yellowShades = [(255, 206, 166), (255, 112, 51), (250, 142, 0), (255, 178, 25), (255, 235, 59)]
    var purpShades = [(128, 31, 166), (174, 0, 255), (125, 115, 235), (113, 36, 214)]
    var pinkShades = [(196, 24, 84), (235, 30, 92), (242, 100, 142), (250, 187, 206)]
    
    var colors:[UIColor] = []
    var shades:[(Int, Int, Int)] = []
    var totalShades:[(Int, Int, Int)] = []
    
    if !(shade=="blue"){ shades += blueShades }
    if !(shade=="turquoise"){ shades += turqShades }
    if !(shade=="pink"){ shades += pinkShades }
    if !(shade=="red"){ shades += redShades }
    if !(shade=="green"){ shades += greenShades }
    if !(shade=="yellow"){ shades += yellowShades }
    if !(shade=="purple"){ shades += purpShades }
    
    shades = sorted(shades) {_, _ in arc4random() % 2 == 0}
    
    for color in shades {
        colors.append(UIColor(red: (CGFloat(color.0))/255, green: (CGFloat(color.1))/255, blue: (CGFloat(color.2))/255, alpha: 1.0))
    }
    
    colors = sorted(colors) {_, _ in arc4random() % 2 == 0}
    return colors
}

func getWinColor() -> String {
    let ind = Int(arc4random_uniform(UInt32(winColorList.count)))
    let winColor = winColorList[ind]
    return winColor
    
}

func getSides(num:Int)->(Int,Int){
    var factors:[(Int, Int)] = []
    for var i:Int = 2; i < num; i++ {
        
        if i * (num/i) == num {
            let t = (num/i, i)
            
            factors.append(t)
        }
    }
    
    var difference:[Int] = []
    
    for item in factors{
        difference.append(abs(item.0-item.1))
    }
    
    let numMin = difference.reduce(Int.max, { min($0, $1) })
    var index = find(difference, numMin)
    
    return ((factors[index!].1, factors[index!].0))
}


func findBlocksNum(level:Int) -> Int{
    var numbers = [2, 4, 6, 8, 9, 10, 12 , 15, 16, 18, 20, 21, 24, 25, 27, 28, 30, 32, 33, 35, 36, 39, 40, 42, 44, 45, 48, 49, 50, 51, 52, 54, 55, 56, 60, 63, 64, 65, 66, 68, 69, 70, 72, 75, 76, 77, 78, 80, 81, 82, 84, 85, 88, 90, 91, 92, 93, 96, 98, 99, 100]
    
    
    return numbers[level]
}

// GAMECENTER
func saveHighscore(score:Int) {  //check if user is signed in
    if GKLocalPlayer.localPlayer().authenticated {
        
        var scoreReporter = GKScore(leaderboardIdentifier: "colorific_board") //leaderboard id here
        
        scoreReporter.value = Int64(score) //score variable here (same as above)
        
        var scoreArray: [GKScore] = [scoreReporter]
        
        GKScore.reportScores(scoreArray, {(error : NSError!) -> Void in
            if error != nil {
            }
        })
    }
}




