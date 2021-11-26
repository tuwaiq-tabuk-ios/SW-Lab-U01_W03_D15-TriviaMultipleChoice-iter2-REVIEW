//
//  QuestionManager.swift
//  TriviaMultipleChoice-Shuruq
//
//  Created by Shorouq AlAnzi on 15/03/1443 AH.
//



import Foundation
import UIKit
import AVFoundation

struct QuizManager {
  
  var player: AVAudioPlayer?
  var playerErrors : AVAudioPlayer?
  
  // 
  private var questionNumber = 0
  private var score = 0
  
  let quiz = [
    Question(question: "Which is the world's tallest peak?",
             answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"],
             correctAnswer:"Everest"),
    
    Question(question: "Which is the Capital of Australia?",
             answers: ["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"] ,
             correctAnswer: "Canberra"),
    
    Question(question: "Rigoletto opera was composed by" ,
             answers: ["Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi", "Richard Wagner"],
             correctAnswer: "Giuseppe Verdi"),
    
    Question(question: "Turandot opera was composed by",
             answers: ["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"],
             correctAnswer: "Giacomo Puccini" ),
    
    Question(question: "The magic flute opera was composed by",
             answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"] ,
             correctAnswer: "Wolfgang Amadeus Mozart")]
  
  
  mutating func checkAnswer(_ userAnswer:String) -> Bool {
    
    print(userAnswer)
    print(quiz[questionNumber].correctAnswer)
    
    if userAnswer == quiz[questionNumber].correctAnswer {
      score += 5
      return true
    } else {
      score -= 10
      return false
    }
  }
  
  
  func getScore() -> Int {
    return score
  }
  
  
  func getQuestion() -> String {
    quiz[questionNumber].question
  }
  
  
  func getChoices() -> [String] {
    
    return quiz[questionNumber].answers
  }
  
  
  func getProgress() -> Float {
    Float (questionNumber + 1 ) / Float(quiz.count)
  }
  
  
  mutating func nextQuestion() -> Bool{
    
    if (questionNumber + 1 <  quiz.count) {
      questionNumber += 1
      return true
      
    } else {
      return false
    }
  }
  
  
  mutating func hasUserGoodScore() -> Bool {
    
    let maxScore = quiz.count * 5
    
    let reqScore = Double(maxScore) * 0.7
    
    return Double(score) >= reqScore ? true : false
    
  }
  
  
  mutating func startGame(){
    score = 0
    questionNumber = 0
  }
  
  
  mutating func playSound() {
    
    guard let url = Bundle.main.url(forResource: "clapping",
                                    withExtension: "mp3") else { return }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      /* The following line is required for the player to work on
       iOS 11. Change the file type accordingly*/
      
      player = try AVAudioPlayer(contentsOf: url,
                                 fileTypeHint: AVFileType.mp3.rawValue)
      
      guard let player = player else { return }
      
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  func stopSound(){
    player?.stop()
  }
  
  
  mutating func playError() {
    
    guard let url = Bundle.main.url(forResource: "error",
                                    withExtension: "mp3") else { return }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      /* The following line is required for the player to work on
       iOS 11. Change the file type accordingly*/
      
      playerErrors = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      guard playerErrors != nil else { return }
      
      playerErrors!.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
}
