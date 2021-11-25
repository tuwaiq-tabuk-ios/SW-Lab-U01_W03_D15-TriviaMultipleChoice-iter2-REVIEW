//
//  QuestionBank.swift
//  TriviaMultipleChoice_mohammed_alatawi_ Project2
//
//  Created by محمد العطوي on 08/04/1443 AH.
//

import UIKit
import AVFoundation

struct QuestionBank {
  var player:AVAudioPlayer?
  
  private let questions = [
    Question(
      question:
        "First IOS Was Written In?".localize(),
      answers: ["1984", "1985", "1986", "1987"],
      correctAnswer: "1986"
    ),
    Question(
      question:
        "To Create Contants In Swift We Use Keyword ?".localize(),
      answers:
        ["Conts", "Let", "Contants", "None Of Above"],
      correctAnswer: "Let"
    ),
    Question(
      question:
        "To Initialize Variable With Null Require ?".localize(),
      answers:
        ["?", " !"," _", "NULL"],
      correctAnswer: "?"
    ),
    Question(
      question:
        "Which Of The Following Is Incorrect Value Type Of The Swift ?".localize(),
      answers:
        ["Double", " Character", "Enum", "Class"],
      correctAnswer: "Class"
    ),
    Question(
      question:
        "Which Of The Following Declares A Mutable Array In Swift?".localize(),
      answers:
        ["Let X =[Int]()", "Var X=[Int]", "Var X=[Int]()", "Let X =[Int]"],
      correctAnswer: "Var X=[Int]()"
    )
  ]
  
  private var currentQuestionIndex = 0
  private var score = 0
  
  
  mutating func checkAnswers(_ userAnswer: String) -> Bool {
    
    if userAnswer == questions[currentQuestionIndex].correctAnswer{
      score += 5
      return true
    } else {
      score -= 10
      return false
    }
  }  // end func checkAnswers
  
  
  func checkQuestion() -> String {
    
    return questions[currentQuestionIndex].question
  }
  
  
  func checkChoices() -> [String] {
    
    return questions[currentQuestionIndex].answers
  }
  
  
  func checkProgress() -> Float {
    return Float(currentQuestionIndex + 1) / Float(questions.count)
  }
  
  
  func checkScore() -> Int {
    
    return score
  }
  
  
  func totalQuestions() -> Int {
    return questions.count
  }
  
  
  mutating func nextQuestion() -> Bool {
    
    if (currentQuestionIndex + 1 < questions.count){
      currentQuestionIndex += 1
      
      return true
    }
    else{
      return false
    }
  }
  
  
  mutating func start() {
    currentQuestionIndex = 0
    score = 0
  }
  
  
  mutating func playSound(_ name:String) {
    
    guard let url = Bundle.main.url(forResource: name, withExtension: .none) else { return }
    
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
  
  
  mutating func hasUserGoodScore() {
    let percentOfScore = (Float (5 * totalQuestions()) * 0.7)
    Float(score) > percentOfScore ? playSound("clap.wav") : playSound("baz.mp3")
  }
  

  func stopSound() {
    
    player?.stop()
  }
}



