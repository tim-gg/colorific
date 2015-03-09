//
//  GameViewController.swift
//  colorific
//
//  Created by Tim on 2014-12-30.
//  Copyright (c) 2014 Tim. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData
import Social
import GameKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as MainMenuScene
            archiver.finishDecoding()
            
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    override func viewDidLoad() {
        authenticateLocalPlayer()
        
        super.viewDidLoad()
        if let scene = MainMenuScene.unarchiveFromFile("GameScene") as? MainMenuScene {
            // Configure the view.
            
        
            let skView = self.view as SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */

            scene.scaleMode =  .Fill
            
            skView.presentScene(scene)
             NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tweet"), name: "tweet", object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("post"), name: "post", object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("showLeader"), name: "gameCenter", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("authenticateLocalPlayer"), name: "logIn", object: nil)
        }
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func tweet() {
        
        let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        tweetSheet.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                //Add code to deal with it being cancelled
                break
                
            case SLComposeViewControllerResult.Done:
                //Add code here to deal with it being completed
                //Remember that dimissing the view is done for you, and sending the tweet to social media is automatic too. You could use this to give in game rewards?
                break
            }
        }
        var level = NSUserDefaults().integerForKey("highscore")
        tweetSheet.setInitialText("HEY! I made it to \(level) level in COLORIFIC") //The default text in the tweet
        tweetSheet.addImage(UIImage(named: "screen2")) //Add an image if you like?
        tweetSheet.addURL(NSURL(string: "http://twitter.com")) //A url which takes you into safari if tapped on
        
        self.presentViewController(tweetSheet, animated: false, completion: {
            //Optional completion statement
        })}
    
    func post() {
        
        let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        tweetSheet.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                //Add code to deal with it being cancelled
                break
                
            case SLComposeViewControllerResult.Done:
                //Add code here to deal with it being completed
                //Remember that dimissing the view is done for you, and sending the tweet to social media is automatic too. You could use this to give in game rewards?
                break
            }
        }
        
        var level = NSUserDefaults().integerForKey("highscore")
        tweetSheet.setInitialText("HEY! I made it to \(level) level in COLORIFIC") //The default text in the tweet
        tweetSheet.addImage(UIImage(named: "screen1")) //Add an image if you like?
        tweetSheet.addURL(NSURL(string: "http://facebook.com")) //A url which takes you into safari if tapped on
        
        self.presentViewController(tweetSheet, animated: false, completion: {
            //Optional completion statement
        })}

    


    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showLeader() {
        var vc = self.view?.window?.rootViewController
        var gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        vc?.presentViewController(gc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!)
    {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func authenticateLocalPlayer(){
        var localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                //These 2 lines are the only parts that have been changed
                let vc: UIViewController = self.view!.window!.rootViewController!
                vc.presentViewController(viewController, animated: true, completion: nil)
            }
            else {
                //println((GKLocalPlayer.localPlayer().authenticated))
            }
        }
    }}
