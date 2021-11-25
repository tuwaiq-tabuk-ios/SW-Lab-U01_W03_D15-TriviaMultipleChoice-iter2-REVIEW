

import Foundation


struct QuizBrain {

  var score: Int = 0
  var currentQuestionIndex: Int = 0
  var correct: Int = 0
  var wrong: Int = 0
  
  
  private let questions :[Question] = [
    Question(question: "Which is the world's tallest peak?",
             answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"],
             correctAnswer: "Everest"),
    Question(question: "Which is the Capital of Australia?",
             answers:["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"] ,
             correctAnswer: "Canberra"),
    Question(question: "Rigoletto opera was composed by",
             answers: ["Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi", "Richard Wagner"],
             correctAnswer: "Giuseppe Verdi"),
    Question(question: "Turandot opera was composed by?",
             answers:["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"],
             correctAnswer: "Giacomo Puccini"),
    Question(question: "The magic flute opera was composed by",
             answers:  ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"],
             correctAnswer: "Wolfgang Amadeus Mozart"),
  ]
  
  var question: Question {
    questions[currentQuestionIndex]
  }
  
  var answers: [String] {
    questions[currentQuestionIndex].answers
  }

  
  
  mutating func checkAnswer(tag: Int) -> Bool {
    if question.answers[tag] == question.correctAnswer {
      score += 5
//      if hasUserGoodScore() {
//        playClapSound()
//      }
      return true
    } else {
//      playBadSound()
      score -= 10
      return false
    }
  }
  
  
  mutating func nextQuestion() -> Bool {
    if currentQuestionIndex < questions.count-1 {
      currentQuestionIndex += 1
//      update()
      return true
    } else {
    }
//    enableAll()
    return false
  }
  
  func hasUserGoodScore() -> Bool {
    let maxScore = questions.count * 5
    let reqScore = Double(maxScore) * 0.7
    return Double(score) >= reqScore ? true : false
  }
  
  //اذا ٧٠٪ من النتيجة خطائه يطلع رسالة قيم اوفر
  func isGameOver() -> Bool {
    let maxScore = (questions.count * 10) * -1
    let reqScore = Double(maxScore) * 0.7
    print(maxScore,reqScore, Double(score))
    return Double(score) <= reqScore ? true : false
    
  }
  
  
  func getProgress() -> Float {
    let total = Float(Float(currentQuestionIndex + 1) /  Float(questions.count)) * 100.0
    return total
  }
  
}
