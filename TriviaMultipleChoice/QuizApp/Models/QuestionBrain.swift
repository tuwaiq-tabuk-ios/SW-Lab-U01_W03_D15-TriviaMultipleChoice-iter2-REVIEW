//
//  QuestionBrain.swift
//  QuizApp
//
//  Created by Abdulaziz Hussien on 10/04/1443 AH.
//

import UIKit
import AVFoundation

struct QuestionBrain {
  private var player:AVAudioPlayer?
  
 private let quiz: [Question] = [
  Question(question: "Which is the world's tallest peak?", answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"], correctAnswer: "Everest"),
  
  Question(question: "Which is the Capital of Australia", answers: ["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"],correctAnswer: "Canberra"),
  
  Question(question: "Rigoletto opera was composed by", answers: ["Giacomo Puccini", "Wolfgang Amadeus Mozart","Giuseppe Verdi", "Richard Wagner"], correctAnswer: "Giuseppe Verdi"),
  
  Question(question:"Turandot opera was composed by",
           answers: ["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"],
             correctAnswer: "Giacomo Puccini")
  ,
  Question(question: "The magic flute opera was composed by",
           answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"],
             correctAnswer: "Wolfgang Amadeus Mozart")
  ]
  
  private var questionNumber = 0
  private var score = 0
  
  func totalQuestionCount() -> Int {
    return quiz.count
  }
  
  func questions() -> [Question] {
    return quiz
  }
  
  mutating func checkAnswer(_ answer:String) -> Bool {
    if answer == quiz[questionNumber].correctAnswer{
      score += 5
      return true
    }else{
      score -= 10
      return false
    }
  }
  
  func numberOfQuestion() -> Int {
    return questionNumber
  }
  
  func scoreOfUser() -> Int {
    return score
  }
  
  mutating func nextQuestion() {
    questionNumber += 1
  }
  
  mutating func userHasScore() -> Bool {
    let ratio = (Float(5 * totalQuestionCount()) * 0.7)
    Float(score) > ratio ? playSound("clapping.mp3") : playSound("y2mate.mp3")
    return Float(score) > ratio ? true:false
  }
  
  mutating func restart() {
     score = 0
     questionNumber = 0
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
  
  func stopSound() {
    player?.stop()
  }
  
}
