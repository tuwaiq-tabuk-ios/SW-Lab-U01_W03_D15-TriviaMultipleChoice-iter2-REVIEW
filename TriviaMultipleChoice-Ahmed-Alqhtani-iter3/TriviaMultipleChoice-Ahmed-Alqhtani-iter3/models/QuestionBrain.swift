//
//  QuestionBrain.swift
//  TriviaMultipleChoice-Ahmed-Alqhtani-iter3
//
//  Created by Ahmed awadh alqhtani on 11/04/1443 AH.
//

import UIKit
import AVFoundation

struct QuestionBrain {
  
  private var score = 0
  private var questionNumber = 0
  
  private var player:AVAudioPlayer?
  
   let questions: [Question] = [
    Question(question: "In 1768, Captain James Cook set out to explore which ocean?",
             answers: ["Pacific Ocean",
                       ". Atlantic Ocean",
                       "Indian Ocean",
                       "Arctic Ocean"],
             correctAnswer: "Pacific Ocean"),
    
    Question(question: "Which of the following is not an international organisation?",
             answers: [" FIFA",
                       " NATO",
                       " ASEAN",
                       " FBI"],
             correctAnswer: " FBI"),
    
    Question(question: " Which of the following disorders is the fear of being alone?",
             answers: ["Agoraphobia",
                       "Aerophobia",
                       "Acrophobia",
                       "Arachnophobia"],
             correctAnswer: "Agoraphobia"),
    
    Question(question: "What is the speed of sound?",
             answers: ["120 km/h",
                       "1,200 km/h",
                       "400 km/h",
                       "700 km/h"],
             correctAnswer: "1,200 km/h"),
    
    Question(question: " What do we call a newly hatched butterfly?",
             answers: [". A moth",
                       " A butter",
                       " A caterpillar",
                       "A chrysalis"],
             correctAnswer: " A caterpillar")
  ]
  
  
  
  func totalQuestionCount() -> Int {
    return questions.count
  }
  
//
//    mutating func questions() -> [Question] {
//      return questions
//    }
//  
  
  mutating func checkAnswer(_ answer:String) -> Bool {
    if answer == questions[questionNumber].correctAnswer {
      score += 5
      return true
    } else {
      score -= 10
      return false
    }
  }
  
  
    func numberOfQuestion() -> Int {
      return questionNumber
    }
  
  
  func userScore() -> Int {
    return score
  }
  
  
  mutating func nextQuestion() -> Bool {
    if questionNumber < (questions.count - 1) {
      questionNumber += 1
      
      return true
    } else {
      return false
    }
  }
  
  
  mutating func hasUserGoodScore() -> Bool {
    let ratio = (Float(5 * totalQuestionCount()) * 0.7)
    Float(score) > ratio ? playSound("clapping.mp3") : playSound("Buzzer.mp3")
    
    return Float(score) > ratio ? true:false
    
  }
  
  mutating func restart() {
    score = 0
    questionNumber = 0
    
  }
  
  
  mutating func playSound(_ name:String) {
    guard let url = Bundle.main.url(forResource: name, withExtension: .none) else { return
      
    }
    
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
  
  func stopSound() {
    player?.stop()
  }
  
}
