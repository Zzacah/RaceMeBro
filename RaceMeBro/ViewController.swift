//
//  ViewController.swift
//  RaceMeBro
//
//  Created by Zach Scott on 2017-05-02.
//  Copyright © 2017 Zach Scott. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickedStart(_ sender: Any) {
        
        // make button unclickable
        
        startButton.isUserInteractionEnabled = false
        
        // generate a random number for the second delay
        
        let randomNum:UInt32 = arc4random_uniform(5) // range is 0 to 5
        
        // Initiate "Ready..." screen and play "Ready" sound
        
        startButton.setTitle("Ready...", for: UIControlState.normal)
        startButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        view.backgroundColor = UIColor.orange
        self.readySound()
        
        // 4 seconds after "Ready" executes, initiate "Set..." screen and play "Set" sound
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.startButton.setTitle("Set...", for: UIControlState.normal)
            self.view.backgroundColor = UIColor.init(red: 206/255, green: 196/255, blue: 0, alpha: 1)
            self.setSound()
            
            // 2 seconds after "Set..." initiate "GO!" screen and play gunshot
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1 + Int(randomNum)), execute: {
                self.startButton.setTitle("GO!", for: UIControlState.normal)
                self.view.backgroundColor = UIColor.green
                self.goSound()
                
                
                // Reset to initial "Start" screen
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                    self.startButton.setTitle("Start", for: UIControlState.normal)
                    self.startButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
                    self.view.backgroundColor = UIColor.white
                    self.startButton.isUserInteractionEnabled = true // make button clickable again
                })
            })
        })
    }
    
    func readySound() {
        do {
            // address of the music file.
            let ready = Bundle.main.path(forResource: "ready", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: ready!))
            audioPlayer.play()
        }
        catch{
            print(error)
        }
    }
    
    func setSound() {
        do {
            // address of the music file.
            let set = Bundle.main.path(forResource: "set", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: set!))
            audioPlayer.play()
        }
        catch{
            print(error)
        }
    }
    
    func goSound() {
        do {
            // address of the music file.
            let go = Bundle.main.path(forResource: "go", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: go!))
            audioPlayer.play()
        }
        catch{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

