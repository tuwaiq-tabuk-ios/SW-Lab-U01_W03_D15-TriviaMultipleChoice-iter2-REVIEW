//
//  ViewController.swift
//  TriviaMultipleChoice-“Nada_Abdullah”
//
//  Created by apple on 08/04/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  private var quizBrain: QuizBrain = QuizBrain()
  
  var player: AVAudioPlayer?
  
  
  // MARK: - @IBoutlet
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var firstButton: UIButton!
  @IBOutlet weak var secondButton: UIButton!
  @IBOutlet weak var thirdButton: UIButton!
  @IBOutlet weak var fourthButton: UIButton!
  
  
  
  
  // MARK: - Life cycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    configureButtons()
    update()
    
  }
  
  
  
  // MARK: - @IBAction
  
  @IBAction func answerButtonPressed(_ sender: UIButton) {
    disableAll()
    
    if quizBrain.checkAnswer(tag: sender.tag) {
      sender.backgroundColor = .green
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        sender.backgroundColor = .clear
        //        self.nextQuestion()
      }
      
    } else {
      sender.backgroundColor = .red
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        sender.backgroundColor = .clear
        //        self.nextQuestion()
      }
      
      playBadSound()
    }
    
    if quizBrain.nextQuestion() {
      update()
      enableAll()
    } else {
      if quizBrain.hasUserGoodScore() {
        playClapSound()
      }
      showaGameOverAlert()
    }
    
//    if quizBrain.isGameOver() {
//      let alert = UIAlertController(title: "Game Over",
//                                    message: "",
//                                    preferredStyle: .alert)
//      alert.addAction(UIAlertAction(title: "Start Again",
//                                    style: .default,
//                                    handler: self.startOver))
//      self.present(alert, animated: true)
//    }
  }
  
  
  
  // MARK: - UI configuration
  
  func configureButtons() {
    firstButton.layer.cornerRadius = 20
    firstButton.layer.borderWidth = 3
    firstButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    
    secondButton.layer.cornerRadius = 20
    secondButton.layer.borderWidth = 3
    secondButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    
    thirdButton.layer.cornerRadius = 20
    thirdButton.layer.borderWidth = 3
    thirdButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    
    fourthButton.layer.cornerRadius = 20
    fourthButton.layer.borderWidth = 3
    fourthButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
  }
  
  
  func update() {
    let answers = quizBrain.answers
    questionLabel.text = quizBrain.question.question
    firstButton.setTitle(answers[0], for: .normal)
    secondButton.setTitle(answers[1], for: .normal)
    thirdButton.setTitle(answers[2], for: .normal)
    fourthButton.setTitle(answers[3], for: .normal)
    scoreLabel.text = "\(quizBrain.score)"
    let total = quizBrain.getProgress()
    progressBar.progress = total * 0.01
  }
  
  func disableAll() {
    firstButton.isEnabled = false
    secondButton.isEnabled = false
    thirdButton.isEnabled = false
    fourthButton.isEnabled = false
  }
  
  
  func enableAll() {
    firstButton.isEnabled = true
    secondButton.isEnabled = true
    thirdButton.isEnabled = true
    fourthButton.isEnabled = true
  }
  
  
  func showaGameOverAlert() {
    let alert = UIAlertController(title: "Done",
                                  message: "",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Start Again",
                                  style: .default,
                                  handler: self.startOver))
    self.present(alert, animated: true)
  }
  
  // MARK: - UI logic
  
  func startOver(_ action: UIAlertAction) {
    quizBrain.score = 0
    quizBrain.currentQuestionIndex = 0
    update()
  }
  
  
  //  func nextQuestion() -> Bool {
  //    if quizBrain.currentQuestionIndex < quizBrain.questions.count-1 {
  //      quizBrain.currentQuestionIndex += 1
  //      update()
  //    } else {
  //      let alert = UIAlertController(title: "Done",
  //                                    message: "",
  //                                    preferredStyle: .alert)
  //      alert.addAction(UIAlertAction(title: "Start Again",
  //                                    style: .default,
  //                                    handler: self.startOver))
  //      self.present(alert, animated: true)
  //    }
  //    enableAll()
  //  }
  
  
  
  // MARK: - Play sound
  func playClapSound() {
    guard let url = Bundle.main.url(forResource: "clap", withExtension: "wav") else { return }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      guard let player = player else { return }
      player.play()
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  func playBadSound() {
    guard let url = Bundle.main.url(forResource: "beep", withExtension: "mp3") else { return }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      guard let player = player else { return }
      player.play()
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
}
