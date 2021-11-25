//
//  ViewController.swift
//  TriviaMultipleChoice-Ahmed-Alqhtani-iter3
//
//  Created by Ahmed awadh alqhtani on 11/04/1443 AH.
//

import UIKit
class ViewController: UIViewController {
  
  var questionBrain = QuestionBrain()
  
  
  // MARK: - @IBOutlet
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var firstChoice: UIButton!
  @IBOutlet weak var secondChoice: UIButton!
  @IBOutlet weak var thirdChoice: UIButton!
  @IBOutlet weak var fourthChoice: UIButton!
  @IBOutlet weak var progressBar: UIProgressView!
  
  
  
  // MARK: - View controller life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureButtons()
    progressBar.progress = 0.0
    updateUI()
 
  }
  
  
  
  // MARK: - @IBAction
  
  @IBAction func answerButton(_ sender: UIButton) {
    let answer = sender.currentTitle!

    if questionBrain.checkAnswer(answer) {
      sender.backgroundColor = .systemGreen
    } else{
      sender.backgroundColor = .systemRed
    }
    
    if questionBrain.nextQuestion() {
      showGoodOrBadAnswer()
    } else {
      questionBrain.hasUserGoodScore()
      showAlert()
    }

  }
  
  
  func configureButtons() {
    questionLabel.layer.cornerRadius = 50
    questionLabel.layer.borderWidth = 5
    questionLabel.layer.borderColor = UIColor.white.cgColor
    questionLabel.layer.masksToBounds = true
    
    firstChoice.layer.cornerRadius = 50
    firstChoice.layer.borderWidth = 2
    firstChoice.layer.borderColor = UIColor.white.cgColor
    firstChoice.layer.masksToBounds = true
    
    secondChoice.layer.cornerRadius = 50
    secondChoice.layer.borderWidth = 2
    secondChoice.layer.borderColor = UIColor.white.cgColor
    secondChoice.layer.masksToBounds = true
    
    thirdChoice.layer.cornerRadius = 50
    thirdChoice.layer.borderWidth = 2
    thirdChoice.layer.borderColor = UIColor.white.cgColor
    thirdChoice.layer.masksToBounds = true
    
    fourthChoice.layer.cornerRadius = 50
    fourthChoice.layer.borderWidth = 2
    fourthChoice.layer.borderColor = UIColor.white.cgColor
    fourthChoice.layer.masksToBounds = true
  }
  
  
  
  
  @objc func updateUI() {
    scoreLabel.text = "\(questionBrain.userScore())"
    questionLabel.text = questionBrain.questions[questionBrain.numberOfQuestion()].question
    
    firstChoice.setTitle(questionBrain.questions[questionBrain.numberOfQuestion()].answers[0], for: .normal)
    secondChoice.setTitle(questionBrain.questions[questionBrain.numberOfQuestion()].answers[1], for: .normal)
    thirdChoice.setTitle(questionBrain.questions[questionBrain.numberOfQuestion()].answers[2], for: .normal)
    fourthChoice.setTitle(questionBrain.questions[questionBrain.numberOfQuestion()].answers[3], for: .normal)

    progressBar.progress
      = Float(questionBrain.numberOfQuestion() + 1) / Float(questionBrain.totalQuestionCount())
    
    firstChoice.backgroundColor = .clear
    secondChoice.backgroundColor = .clear
    thirdChoice.backgroundColor = .clear
    fourthChoice.backgroundColor = .clear
  
  
}



func showGoodOrBadAnswer() {
  Timer.scheduledTimer(
    timeInterval: 0.8,
    target: self,
    selector: #selector(updateUI),
    userInfo: nil,
    repeats: false)
}

func showAlert() {
  
  var title = ""
  var message = ""
  if questionBrain.hasUserGoodScore() {
    title = "Good Luck"
    message = ""
  } else {
    title = "Game Over"
    message = "Do you want to start over?"
  }
  let alert = UIAlertController(title: title,
                                message: message,
                                preferredStyle: .alert)
  
  let action = UIAlertAction(title: "Yes", style: .default) { alerte in
    self.questionBrain.restart()
    self.questionBrain.stopSound()
    self.updateUI()
    
  }
  alert.addAction(action)
  
  self.present(alert, animated: true, completion: nil)
  
}
  


}
