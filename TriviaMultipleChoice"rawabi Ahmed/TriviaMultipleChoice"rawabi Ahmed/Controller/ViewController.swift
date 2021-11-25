//
//  ViewController.swift
//  TriviaMultipleChoice"rawabi Ahmed
//
//  Created by روابي باجعفر on 15/03/1443 AH.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
  
  var quizManager = QuizManager()
  
  var timer:Timer = Timer()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureButons()
    valueScoreLable.text = " \(quizManager.getScore())"
    startGame()
    updateUI()
    progressBottom.progress = 0
  }
  
  

  @IBOutlet weak var valueScoreLable: UILabel!
  @IBOutlet weak var questionLable: UILabel!
  @IBOutlet weak var firstChoiceButtom: UIButton!
  @IBOutlet weak var secandChoiceBottom: UIButton!
  @IBOutlet weak var thirdChoiceButton: UIButton!
  @IBOutlet weak var fourthChoiceButton: UIButton!
  @IBOutlet weak var progressBottom: UIProgressView!
  
  // Do any additional setup after loading the view.
  
  @IBAction func answerButtonPressed(_ sender: UIButton) {
  
  guard let userAnswer = sender.currentTitle else {
        print("ERROR: Button do not have the title property set in storyboard ")
        return
      }
      
      let check = quizManager.checkAnswer(userAnswer)
      
      if check {
        sender.backgroundColor = .systemGreen
      } else {
        sender.backgroundColor = .systemRed
      }
      
    progressBottom.progress = quizManager.getProgress()

      if quizManager.nextQuestion() {
        timer = Timer.scheduledTimer(timeInterval: 0.8,
                                     target: self,
                                     selector: #selector(updateUI),
                                     userInfo: nil,
                                     repeats: false)
        
        
      } else {
        valueScoreLable.text = "\(quizManager.getScore())"
        
        if quizManager.hasUserGoodScore(){
          showGoodScoreAlertMessage()
          quizManager.playSound()
        }else{
          showGameOverAlertMessage()
          quizManager.playError()
        }
      }
  }
  
    // MARK: - UI configureButons
    func  configureButons() {
      
      firstChoiceButtom.layer.cornerRadius = 20
      firstChoiceButtom.layer.borderColor = UIColor.white.cgColor
      firstChoiceButtom.layer.borderWidth = 3
      firstChoiceButtom.titleLabel?.adjustsFontSizeToFitWidth = true
      firstChoiceButtom.titleLabel?.minimumScaleFactor = 0.5
      
      secandChoiceBottom.layer.cornerRadius = 20
      secandChoiceBottom.layer.borderColor = UIColor.white.cgColor
      secandChoiceBottom.layer.borderWidth = 3
      secandChoiceBottom.titleLabel?.adjustsFontSizeToFitWidth = true
      secandChoiceBottom.titleLabel?.minimumScaleFactor = 0.5
      
      thirdChoiceButton.layer.cornerRadius = 20
      thirdChoiceButton.layer.borderColor = UIColor.white.cgColor
      thirdChoiceButton.layer.borderWidth = 3
      thirdChoiceButton.titleLabel?.adjustsFontSizeToFitWidth = true
      thirdChoiceButton.titleLabel?.minimumScaleFactor = 0.5
      
      fourthChoiceButton.layer.cornerRadius = 20
      fourthChoiceButton.layer.borderColor = UIColor.white.cgColor
      fourthChoiceButton.layer.borderWidth = 3
      fourthChoiceButton.titleLabel?.adjustsFontSizeToFitWidth = true
      fourthChoiceButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    
    func startGame(action: UIAlertAction! = nil){
      print(#function)
      quizManager.stopSound()
      quizManager.startGame()
      updateUI()
    }
    
    
    @objc func updateUI(){
      valueScoreLable.text = String(quizManager.getScore())
      
      questionLable.text = quizManager.getQuestion()
      
      
      firstChoiceButtom.backgroundColor = UIColor.clear
      secandChoiceBottom.backgroundColor = UIColor.clear
      thirdChoiceButton.backgroundColor = UIColor.clear
      fourthChoiceButton.backgroundColor = UIColor.clear
      
      
      firstChoiceButtom.setTitle(quizManager.getChoices()[0], for: .normal)
      secandChoiceBottom.setTitle(quizManager.getChoices()[1], for: .normal)
      thirdChoiceButton.setTitle(quizManager.getChoices()[2], for: .normal)
      fourthChoiceButton.setTitle(quizManager.getChoices()[3], for: .normal)
      
      
      //progressBottom.progress = quizManager.getProgress()
    }
    
    
    func showGameOverAlertMessage() {
      
      let ac = UIAlertController(title: "GAME OVER ",
                                 message: "Your scores is \(quizManager.getScore())",
                                 preferredStyle: .alert
      )
      
      ac.addAction(UIAlertAction(title: "Play again",
                                 style: .default,
                                 handler: startGame))
      present(ac, animated: true)
    }
    
    func showGoodScoreAlertMessage() {
      
      if quizManager.hasUserGoodScore() {
        let ac = UIAlertController(title: "Good Job",
                                   message: "Your scores is \(quizManager.getScore())",
                                   preferredStyle: .alert
        )
        
        ac.addAction(UIAlertAction(title: "Play again",
                                   style: .default ,
                                   handler: startGame))
        present(ac, animated: true)
      }
    }
  }


    
