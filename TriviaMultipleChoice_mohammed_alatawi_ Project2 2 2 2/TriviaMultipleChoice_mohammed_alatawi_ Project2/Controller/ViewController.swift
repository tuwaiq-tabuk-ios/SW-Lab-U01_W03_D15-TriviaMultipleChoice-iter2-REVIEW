//
//  ViewController.swift
//  TriviaMultipleChoice_mohammed_alatawi_ Project2
//
//  Created by محمد العطوي on 08/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var valueScoreLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var optionFirstButton: UIButton!
  @IBOutlet weak var optionSecondButton: UIButton!
  @IBOutlet weak var optionThirdButton: UIButton!
  @IBOutlet weak var optionFourthButton: UIButton!
  
  @IBOutlet weak var progressBar: UIProgressView!
  
  var username:String = ""
  
  var triviaBrain = QuestionBank()
  override func viewDidLoad() {
    super.viewDidLoad()
    progressBar.progress = 0.0
    updateScreen()
    
  }
  
  
  @IBAction func answerButtonPressed(_ sender: UIButton) {
    guard let userAnswer = sender.currentTitle else {
      print("ERROR:Button do not have the title property set in storyboard")
      return
    }
    let isRightAnswer = triviaBrain.checkAnswers(userAnswer)
    
    if isRightAnswer{
      sender.backgroundColor = .systemGreen
    }else{
      sender.backgroundColor = .systemRed
      
    }
    if triviaBrain.nextQuestion(){
      
      Timer.scheduledTimer(timeInterval: 1.0,
                           target: self,
                           selector: #selector(updateScreen)
                           , userInfo: nil,
                           repeats: false)
    } else {
      showAlert()
      
    }
  }
  
  
  @objc func updateScreen() {
    
    valueScoreLabel.text = "\(triviaBrain.checkScore())"
    
    questionLabel.text = triviaBrain.checkQuestion()
    
    let answers = triviaBrain.checkChoices()
    optionFirstButton.setTitle(answers[0], for: .normal)
    optionSecondButton.setTitle(answers[1], for: .normal)
    optionThirdButton.setTitle(answers[2], for: .normal)
    optionFourthButton.setTitle(answers[3], for: .normal)
    
    progressBar.progress = triviaBrain.checkProgress()
    
    optionFirstButton.backgroundColor = UIColor.clear
    optionSecondButton.backgroundColor = UIColor.clear
    optionThirdButton.backgroundColor = UIColor.clear
    optionFourthButton.backgroundColor = UIColor.clear
  }
  
  
  func showAlert() {
    let percentOfScore = (Float (5 * triviaBrain.totalQuestions()) * 0.7)
    let message : String
    let message1: String
    
    if triviaBrain.checkScore() > Int(percentOfScore){
      
      message = "Congratulations: %@\n do you want play agin ?".localize()
      message1 = String(format: message, username)
    }else{
      
      message = "Sorry: %@\n do you want play agin ?".localize()
      message1 = String(format: message, username)
      
    }
    
    let alert = UIAlertController(title: "End game".localize(),
                                  message: message1,
                                  preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Yes".localize(), style: .cancel,
                                  handler: { action in
                                    self.triviaBrain.start()
                                    self.updateScreen()
                                    self.triviaBrain.stopSound()
                                    
                                    
                                  }))
    alert.addAction(UIAlertAction(title: "No".localize(), style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
    triviaBrain.hasUserGoodScore()
    
  }
}
