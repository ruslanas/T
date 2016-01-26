//
//  ViewController.swift
//  T
//
//  Created by macos on 26/01/16.
//  Copyright © 2016 macos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var killCount = 0;
    var bornTotal = 0;
    var timer = NSTimer();
    var gameStarted = false;
    
    var words: [String] = ["Faggot", "Loser", "Asshole", "Douchebag", "Fucker", "Chicken", "Bitch", "Cunt"]
    
    override func viewDidLoad() {
        // nothing here
    }
    
    @IBOutlet weak var startButton: UIButton!
    func startGame() {
    
        // we will start timer here
        if(!gameStarted) {
            
            gameStarted = true;
            counter.hidden = false;
            createFrog() // immediately
            
            timer = NSTimer.scheduledTimerWithTimeInterval(
                0.8,
                target: self,
                selector: Selector("createFrog"),
                userInfo: nil,
                repeats: true)
            
            startButton.hidden = true
            
            
        }
    }
    
    @IBOutlet var game: UIView!
    
    func createFrog() {

        let w = self.screenWidth()
        let h = self.screenHeight()
        
        let bw = 150;
        let bh = 50;
        
        let button:UIButton = UIButton(type: UIButtonType.System)
        
        
        button.tintColor = UIColor.whiteColor()
        
        button.frame = CGRect(
            x: max(0, random() % Int(w) - bw),
            y: max(0, random() % Int(h) - bh),
            width: bw,
            height: bh)
        
        
        let phrase = words[random() % words.count]
        
        button.setTitle(phrase, forState: UIControlState.Normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = NSTextAlignment.Center
        
        // follow white rabbit
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        let img = UIImage(named: "rabbit-48.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        button.setImage(
            img,
            forState: UIControlState.Normal)

        
        // do not forget colon after action name
        button.addTarget(self, action: "killFrog:", forControlEvents:UIControlEvents.TouchDown)
        
        self.view.addSubview(button)
        
        if(bornTotal - killCount > 5) {
            
            timer.invalidate()
            gameStarted = false;
            
            let alert = UIAlertController(
                title: "GAME OVER",
                message: "Score: " + String(killCount),
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(
                title: "Got it", style: .Default, handler: {
                    (alert: UIAlertAction) in self.resetGame()
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
         
        }
        
        bornTotal++;
    }
    
    /*
    Clear all generated buttons
    */
    func resetGame() {
        
        startButton.hidden = false
        
        killCount = 0;
        bornTotal = 0;
        counter.text = "0"
        counter.hidden = true;
        
        // delete all frogs
        for view in game.subviews {
            if(view.isKindOfClass(UIButton)) {
                let btn = view as? UIButton
                if(btn?.titleForState(.Normal) != "Start game") {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    func killFrog(sender: UIButton) {
        if(gameStarted) {
            counter.text = String(++killCount)
            sender.removeFromSuperview()
        }
    }
    
    @IBOutlet weak var counter: UILabel!
    @IBAction func theButton(sender: UIButton) {
        
            startGame()
    }
    
    private func screenWidth() -> CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    private func screenHeight() -> CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
}