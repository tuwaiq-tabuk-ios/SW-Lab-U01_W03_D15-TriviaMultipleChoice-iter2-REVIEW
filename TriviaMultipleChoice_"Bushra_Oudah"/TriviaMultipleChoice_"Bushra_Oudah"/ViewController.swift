//
//  ViewController.swift
//  TriviaMultipleChoice_"Bushra_Oudah"
//
//  Created by Bushra alatwi on 15/03/1443 AH.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var valueScoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var Choice_One: UIButton!
    @IBOutlet weak var Choice_Two: UIButton!
    @IBOutlet weak var Choice_Three: UIButton!
    @IBOutlet weak var Choice_Four: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var triviaBrain = TriviaBrain()
    
    var questionNumber:Int = 0
    var player: AVAudioPlayer?
    var nextQuestion:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
        valueScoreLabel.text = "\(triviaBrain.getScore())"
        updateUI()
        progressView.progress = 0.0
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        
        let userAnswer = sender.currentTitle!
        let check = triviaBrain.checkAnswer(userAnswer)
        
        
        if check{
            sender.backgroundColor = UIColor.green
        }
        else {
            sender.backgroundColor = UIColor.red
        }
        
        
        Timer.scheduledTimer(timeInterval:0.2,
                             target: self,
                             selector: #selector(updateUI),
                             userInfo: nil,
                             repeats: false)
        
        
        if triviaBrain.nextQuestion() {
            //updateUI()
        }
        else {
            if triviaBrain.hasUserGoodScore(){
                showGoodScoreAlertMessage()
                triviaBrain.playSound()
            }else{
                showGameOverAlertMessage()
            }
        }
    }
    
    
    func startGame(action : UIAlertAction! = nil) {
        print(#function)
        startGame ()
        updateUI()
    }
    
    @objc func updateUI(){
        
        questionLabel.text = triviaBrain.checkQuestion()
        progressView.progress = triviaBrain.checkProgress()
        valueScoreLabel.text = "\(triviaBrain.getScore())"
        
        
        Choice_One.backgroundColor = UIColor.clear
        Choice_Two.backgroundColor = UIColor.clear
        Choice_Three.backgroundColor = UIColor.clear
        Choice_Four.backgroundColor = UIColor.clear
        
        
        Choice_One.setTitle(triviaBrain.getAnswer()[0], for: .normal)
        Choice_Two.setTitle(triviaBrain.getAnswer()[1], for: .normal)
        Choice_Three.setTitle(triviaBrain.getAnswer()[2], for: .normal)
        Choice_Four.setTitle(triviaBrain.getAnswer()[3], for: .normal)
        
    }
    
   
    
    
    
    
    
    
    func showGameOverAlertMessage(){
     
        let ac = UIAlertController(title: "GAME OVER",
                                   message: "Your scores is \(triviaBrain.getScore())",
                                   preferredStyle: .alert )
        
        
        
        ac.addAction(UIAlertAction(title: "No",
                                   style: .cancel,
                                   handler: {action in exit(0)}))
        
        ac.addAction(UIAlertAction(
                        title: "Yes",
                        style: .default,
                        handler: { action in
                            print("Yes clicked")
                            self.start()
                        }))
        
        present(ac, animated: true, completion: nil)
  
    }
    
    
    func showGoodScoreAlertMessage(){
     
        let ac = UIAlertController(title: "Congratiolation!",
                                   message: "Your scores is \(triviaBrain.getScore())",
                                   preferredStyle: .alert )
        
 
        ac.addAction(UIAlertAction(title: "No",
                                   style: .cancel,
                                   handler: {action in exit(0)}))
        
        ac.addAction(UIAlertAction(
                        title: "Yes",
                        style: .default,
                        handler: { action in
                            print("Yes clicked")
                            self.start()
                        }))
        
        present(ac, animated: true, completion: nil)
  
    }
    
    
  
    func start() {
        triviaBrain.startGame()
        updateUI()
    }
    
    func configureButtons(){
        Choice_One.layer.cornerRadius = 20
        Choice_One.layer.masksToBounds = true
        Choice_One.layer.borderWidth = 3
        Choice_One.layer.borderColor = UIColor.white.cgColor
        Choice_One.titleLabel?.adjustsFontSizeToFitWidth = true
        Choice_One.titleLabel?.minimumScaleFactor = 0.5
        
        
        
        Choice_Two.layer.cornerRadius = 20
        Choice_Two.layer.masksToBounds = true
        Choice_Two.layer.borderWidth = 3
        Choice_Two.layer.borderColor = UIColor.white.cgColor
        Choice_Two.titleLabel?.adjustsFontSizeToFitWidth = true
        Choice_Two.titleLabel?.minimumScaleFactor = 0.5
        
        
        Choice_Three.layer.cornerRadius = 20
        Choice_Three.layer.masksToBounds = true
        Choice_Three.layer.borderWidth = 3
        Choice_Three.layer.borderColor = UIColor.white.cgColor
        Choice_Three.titleLabel?.adjustsFontSizeToFitWidth = true
        Choice_Three.titleLabel?.minimumScaleFactor = 0.5
        
        
        Choice_Four.layer.cornerRadius = 20
        Choice_Four.layer.masksToBounds = true
        Choice_Four.layer.borderWidth = 3
        Choice_Four.layer.borderColor = UIColor.white.cgColor
        Choice_Four.titleLabel?.adjustsFontSizeToFitWidth = true
        Choice_Four.titleLabel?.minimumScaleFactor = 0.5
        
    }
}



