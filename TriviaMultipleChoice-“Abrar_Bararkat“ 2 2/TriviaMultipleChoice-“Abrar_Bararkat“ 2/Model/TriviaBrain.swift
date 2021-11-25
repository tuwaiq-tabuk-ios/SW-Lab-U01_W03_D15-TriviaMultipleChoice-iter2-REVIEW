

import Foundation
import AVFoundation

struct TriviaBrain {
  
  
  // MARK: - variables
  private var score = 0
  private var questionNumber = 0
  private var player: AVAudioPlayer?
  
  
  // MARK: -  Questions Answers Array
  let questions = [
    MultipleChoiceQuestion(
      question: "The language of Saudi Arabia ?",
      answers: ["English", "Arabic","spanish","French"],
      correctAnswer: "Arabic"
    ),
    MultipleChoiceQuestion(
      question: "Capital of Saudi?",
      answers: ["Riyadh", "Jaddah","Abha","Tabuk"],
      correctAnswer: "Riyadh"
    ),
    MultipleChoiceQuestion(
      question: "How many universities are there in Saudi Arabia?",
      answers: ["35", "24","40","37"],
      correctAnswer: "35"),
    
    MultipleChoiceQuestion(
      question: "currency of Saudi is ?",
      answers: ["Euro", "Dollar","Dinar","Riyal"],
      correctAnswer: "Riyal"
    ),
    MultipleChoiceQuestion(
      question: "Saudi Arabia in ?",
      answers: ["Africa", "Euroup","Asia","Australia"],
      correctAnswer: "Asia"
    )
  ]
  
  // MARK: - Methods
  mutating func checkAnswer(_ userAnswer:String) -> Bool {
    print(userAnswer)
    print(questions[questionNumber].correctAnswer)
    
    
    if userAnswer == questions[questionNumber].correctAnswer{
      score += 5
      return true
    } else {
      score -= 10
      return false
    }
  }
  
  func getQuestionNumber() -> Int {
    return questionNumber
  }
  
  
  func getQuestion() -> String {
    return questions[questionNumber].question
  }
  
  
  func getChoices() -> [String] {
    return questions[questionNumber].answers
  }
  
  
  func getProgress() -> Float {
    return Float(questionNumber + 1) / Float(questions.count);
  }
  
  
  func getScore() -> Int {
    return score
  }
  
  
  mutating func nextQuestion() -> Bool {
    
    if (questionNumber + 1 < questions.count){
      questionNumber += 1
      return true
    } else {
      return false
    }
  }
  
  
  mutating func startGame() {
    questionNumber = 0
    score = 0
  }
  
  
  mutating func hasUserGoodScore() -> Bool {
    
    let getScore = getScore()
    print("get score: \(getScore)")
    
    
    let maxScore = ( Float(getScore) * 0.7 )
    print("max score: \(maxScore)")
    
    
    return Float(getScore) >= maxScore ? true : false
  }
  
  
  mutating func playSound() {
    guard let path = Bundle.main.path(forResource: "clap", ofType:"wav") else {
      return }
    let url = URL(fileURLWithPath: path)
    
    
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.play()
      
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  mutating func stopSound() {
    player?.stop()
  }
  
}




