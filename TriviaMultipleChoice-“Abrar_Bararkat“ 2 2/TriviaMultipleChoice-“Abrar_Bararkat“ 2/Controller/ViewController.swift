//
//  ViewController.swift
//  TriviaMultipleChoice-“Abrar_Bararkat“ 2
//
//  Created by ABRAR ALQARNI on 15/03/1443 AH.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
  
  // MARK: - @IBoutlet
  
  @IBOutlet weak var valueScoreLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var optionFirstButton: UIButton!
  @IBOutlet weak var optionSecondButton: UIButton!
  @IBOutlet weak var optionThirdButton: UIButton!
  @IBOutlet weak var optionFourthButton: UIButton!
  
  @IBOutlet weak var progressBar: UIProgressView!
  
  
  // MARK: -custom properties
  internal var timer: Timer!
  internal var triviaBrain = TriviaBrain()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureButons()
    
    startGame()
  }
  
  
  // MARK: - Methods
  private func configureButons() {
    configureButton(button: optionFirstButton)
    configureButton(button: optionSecondButton)
    configureButton(button: optionThirdButton)
    configureButton(button: optionFourthButton)
  }
  
  
  private func configureButton(button : UIButton) {
    button.layer.borderWidth = 3
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.cornerRadius = 35
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.minimumScaleFactor = 0.5
  }
  
  
  func clearButtonBackground()  {
    optionFirstButton.backgroundColor = .clear
    optionSecondButton.backgroundColor = .clear
    optionThirdButton.backgroundColor = .clear
    optionFourthButton.backgroundColor = .clear
  }
  
  
  func updateProgressView (){
    progressBar.progress = triviaBrain.getProgress()
  }
  
  
  @objc func updateUI(){
    
    
    questionLabel.text = triviaBrain.getQuestion()
    valueScoreLabel.text = "\(triviaBrain.getScore())"
    
    
    let possibleAnswers = triviaBrain.getChoices()
    
    
    
    optionFirstButton.setTitle(possibleAnswers[0],   for: .normal);
    optionSecondButton.setTitle(possibleAnswers[1],  for: .normal)
    optionThirdButton.setTitle(possibleAnswers[2],   for: .normal)
    optionFourthButton.setTitle(possibleAnswers[3],  for: .normal)
    
    
    clearButtonBackground()
  }
  
  func showAlert(myTitle: String) {
    
    
    let alert = UIAlertController(title: myTitle,
                                  message: "play again ?",
                                  preferredStyle: .alert)
    
    
    alert.addAction(UIAlertAction(title: "Yes",
                                  style: .cancel,
                                  handler: { action in
                                    print("Yes clicked")
                                    self.startGame()
                                  }))
    
    
    alert.addAction(UIAlertAction(title: "No",
                                  style: .default,
                                  handler: { action in exit(0)} ))
    present(alert,
            animated: true,
            completion: nil)
    
    
  }
  
  
  func startGame() {
    triviaBrain.startGame()
    triviaBrain.stopSound()
    updateUI()
    progressBar.progress = 0.0
    
  }
  
  // MARK: - @IBAction
  @IBAction func answerButtonPressed(_ sender: UIButton) {
    guard let userAnswer = sender.currentTitle else {
      return
    }
    
    
    let userAnswerIsCorrect = triviaBrain.checkAnswer(userAnswer)
    
    
    if userAnswerIsCorrect {
      sender.backgroundColor = UIColor.green
    } else {
      sender.backgroundColor = UIColor.red
    }
    
    
    Timer.scheduledTimer(timeInterval: 1,
                         target: self,
                         selector: #selector(updateUI),
                         userInfo: nil,
                         repeats: false)
    
    
    updateProgressView()
    
    
    if triviaBrain.nextQuestion() {
      
      print(" Next Question is: \(triviaBrain.getQuestion())")
      
    } else {
      if triviaBrain.hasUserGoodScore() {
        showAlert(myTitle: " Good Scor ")
        triviaBrain.playSound()
        
      } else {
        showAlert(myTitle: "Game Over !")
      }
    }
  }
}






