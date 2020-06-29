//
//  ViewController.swift
//  X-O
//
//  Created by Batool Hussain on 6/28/20.
//  Copyright © 2020 Batool Hussain. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation



class ViewController: UIViewController {
    @IBOutlet weak var turnLabel: UILabel!
    
    
    //  buttons
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet var b5: UIButton!
    @IBOutlet var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet var b9: UIButton!
    @IBOutlet weak var m2: UIButton!
    
    
    
    //    Score
    @IBOutlet weak var xScoreLabel: UILabel!
    @IBOutlet weak var oScoreLabel: UILabel!
    
    
    // background
    @IBOutlet weak var background: UIImageView!
    
    
    var buttons: [UIButton] = []
    
    var counter = 0
    
    
    // background Array
    
    var backgroundArray = [ UIImage(imageLiteralResourceName: "a1"),
                            UIImage(imageLiteralResourceName: "a2"),
                            UIImage(imageLiteralResourceName: "a3"),
                            UIImage(imageLiteralResourceName: "a4")]
    
    
    @IBAction func backgroundchanged() {
        
        background.image = backgroundArray.randomElement()
        
    }
    
    
    //  music
    
    var duck: AVAudioPlayer?
    
    var rooster: AVAudioPlayer?
    
    var winner: AVAudioPlayer?
    
    
    //   scoreCounter
    
    var scoreXcounter = 0
    
    var scoreOcounter = 0
    
    override func viewDidLoad() {
        buttons = [b1, b2, b3, b4, b5, b6, b7, b8, b9]
        super.viewDidLoad()
//    musicLabel.backgroundColor = UIButton.green
  
    }
    
    
    // winning music
    
    func playWinner(){
        
        let path = Bundle.main.path(forResource: "winner.m4a", ofType:nil)!
        
        let url = URL(fileURLWithPath: path)
        
        do {
            
            winner = try AVAudioPlayer(contentsOf: url)
            
            winner?.play()
            
        } catch {
            
            // couldn't load file :(
            
        }
        
    }
    
    
    // X music
    
    func playDuck(){
        
        let path = Bundle.main.path(forResource: "duck.m4a", ofType:nil)!
        
        let url = URL(fileURLWithPath: path)
        
        
        
        do {
            
            duck = try AVAudioPlayer(contentsOf: url)
            
            duck?.play()
            
        } catch {
            
            // couldn't load file :(
            
        }
        
    }
    
    // O music
    func playRooster(){
        let path = Bundle.main.path(forResource: "rooster.m4a", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            
            rooster = try AVAudioPlayer(contentsOf: url)
            
            rooster?.play()
            
        } catch {
            // couldn't load file :(
        }
    }
    
    
    
    //    press 9 buttons
    
    @IBAction func press(_ sender: UIButton) {
        
        
        if counter % 2 == 0 {
            
            sender.setTitle("X", for: .normal)
            
            //            x color
            sender.setTitleColor(.green, for: .normal)
            //            Haptic
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            playDuck()
            
            turnLabel.text = "O Turn"
            
        }else{
            
            sender.setTitle("O", for: .normal)
            //            o color
            sender.setTitleColor(.red, for: .normal)
            
            //            Haptic
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            playRooster()
            
            turnLabel.text = "X Turn"
            
        }
        
        counter += 1
        
        sender.isEnabled = false
        
        winning(winner: "X")
        
        winning(winner: "O")
    }
    
    
    
    //    Reset button
    
    
    @IBAction func resetTapped() {
        
        self.restartGame()
        
    }
    
    
    //    Play Again ( restart game + restart score)
    
    @IBAction func playAgain() {
        
        self.restartGame()
        
        self.restartScore()
    }
    
    
    //    Restar game Func
    
    func restartGame(){
        
        for b in buttons{
            
            b.setTitle("",for: .normal)
            
            b.titleLabel?.text = ""
            
            b.isEnabled = true
            
        }
        
        counter = 0
        
        turnLabel.text = "X Turn"
        
    }
    
    
    //    Restart score func
    
    func restartScore(){
        
        self.oScoreLabel.text = " "
        
        self.xScoreLabel.text = " "
        
        scoreXcounter = 0
        
        scoreOcounter = 0
        
    }
    
    
    //  winning
    
    func winning(winner: String)
        
    { if
        
        ( b1.titleLabel?.text == winner && b2.titleLabel?.text == winner && b3.titleLabel?.text == winner) ||
            
            ( b4.titleLabel?.text == winner && b5.titleLabel?.text == winner && b6.titleLabel?.text == winner) ||
            
            ( b7.titleLabel?.text == winner && b8.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            
            ( b1.titleLabel?.text == winner && b4.titleLabel?.text == winner && b7.titleLabel?.text == winner) ||
            
            ( b2.titleLabel?.text == winner && b5.titleLabel?.text == winner && b8.titleLabel?.text == winner) ||
            
            ( b3.titleLabel?.text == winner && b6.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            
            ( b1.titleLabel?.text == winner && b5.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            
            ( b3.titleLabel?.text == winner && b5.titleLabel?.text == winner && b7.titleLabel?.text == winner)
        
    {
        
        print("\(winner) winner🎉")
        
        
        //     councting the scores
        
        if winner == "X"{
            
            self.scoreXcounter += 1
            
            self.xScoreLabel.text = String(self.scoreXcounter)
            
        }else if winner == "O"{
            
            self.scoreOcounter += 1
            
            self.oScoreLabel.text = String(self.scoreOcounter)
            
        }
        
        self.restartGame()
        
        
        //     score = 3 > winner
        
        if scoreXcounter == 3{
            
            playWinner()
            
            let alertController = UIAlertController(title: "\(winner) has won 3 times 🎉", message: "Click on the play button to play again", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Play Again", style: .cancel) { (alert) in
                
                self.restartGame()
                
                self.restartScore()
            }
            
            alertController.addAction(restartAction)
            
            present(alertController, animated: true, completion: nil)
            
        }else if  scoreOcounter == 3 {
            playWinner()
            
            let alertController = UIAlertController(title: "\(winner) has won 3 times 🎉", message: "Click on the play button to play again", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Play Again", style: .cancel) { (alert) in
                
                self.restartGame()
                
                self.restartScore()
            }
            
            alertController.addAction(restartAction)
            
            present(alertController, animated: true, completion: nil) }
        
        
        //   Draw
        
    }else if counter == 9 {
        
        print("Draw")
        
        let alertControllar = UIAlertController(title: "No one wins", message: "Now reset the game!", preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: "Reset", style: .cancel) { (alert) in self.restartGame() }
        
        alertControllar.addAction(restartAction)
        
        present(alertControllar, animated: true, completion: nil)
        
        
        }
        
        
        
    }
    
    //    background music
    
    @IBOutlet weak var musicLabel: UIButton!
   
    var player: AVAudioPlayer?
   
    @IBAction func playMusic() {
        
        if let player = player, player.isPlaying {
            
            player.stop()
        }
            
        else{
            
            let urlString = Bundle.main.path(forResource: "background1", ofType: "mp3")
            
            do{
                
                try AVAudioSession.sharedInstance().setMode(.default)
                
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                
                guard let urlString = urlString else {
                    
                    return
                    
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                
                player.play()
            }
                
            catch{
                
                print("error")
                
            }
        }
    }
    
}

