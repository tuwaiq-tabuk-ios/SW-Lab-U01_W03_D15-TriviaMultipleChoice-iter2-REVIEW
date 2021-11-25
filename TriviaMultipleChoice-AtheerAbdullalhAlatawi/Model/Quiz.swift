//
//  Quiz.swift
//  TriviaMultipleChoice-AtheerAbdullalhAlatawi
//
//  Created by Atheer abdullah on 19/04/1443 AH.
//

import Foundation

struct Quiz {
  
  
  internal var score = 0
  private var questionNumber = 0
  
  private let quiz = [
    QuestionsAndAnswers(question: "Q1: Captain James Cook set out to explore which ocean?", choices: ["Pacific Ocean", "Atlantic Ocean", "Indian Ocean", "Arctic Ocean"], answer: "Pacific Ocean"),
    QuestionsAndAnswers( question: " Q2:  What is actually electricity?", choices: [ "a flow of water","a flow of air","a flow of electrons","a flow of atoms"], answer: "a flow of electrons"),
    QuestionsAndAnswers(question: "Q3:  Which is the smallest country in the world ?", choices: ["Vatican City","Vanuatu","Monaco","Kuwait"], answer: "Vatican City"),
    QuestionsAndAnswers(question: "Q4:  The phrase: ”I think, therefore I am” was coined by which philosopher?", choices: ["Socrates"," Aristotle"," Plato","Descartes"], answer: "Descartes"),
    QuestionsAndAnswers(question: "Q5: What is the main component of the sun?", choices: [ "Liquid lava", "Gas","Molten iron","Rock"], answer: " Gas"),
    QuestionsAndAnswers(question: "Q6: What is the speed of sound?", choices: ["120 km/h", " 1,200 km/h", " 400 km/h "
                                                                               ,"700 km/h"], answer: " 1,200 km/h"),
    QuestionsAndAnswers(question: "Q7 : In total, how many novels were written by the Bronte sisters?", choices: ["4","5","6","7"], answer: "7"),
    
    QuestionsAndAnswers(question: "Q8: Which was the first film by Disney to be produced in colour?", choices: ["Toy Story", "Sleeping Beauty","Snow White and the Seven Dwarfs","Cinderella"], answer: "Snow White and the Seven Dwarfs")
  ]
  
  func getQuestion() -> String {
    return self.quiz[questionNumber].question
  }
  func getChoices() -> [String]{
    return self.quiz[questionNumber].choices
  }
  
  
  
  mutating func checkAnswer(_ selectedChoice:String) -> Bool{
    if selectedChoice == quiz[questionNumber].answer{
      score += 5
      return true
    }
    score -= 10
    return false
  }
  
  
  mutating func nextQuestion() -> Bool{
    questionNumber += 1
    if questionNumber < quiz.count {
      return true
    } else{
      questionNumber = 0
      return false
    }
  }
  
  
  func getScore() -> Int{
    return score
  }
  
  
  func getProgress() -> Float{
    return Float(questionNumber) / Float(quiz.count);
  }
  
}
