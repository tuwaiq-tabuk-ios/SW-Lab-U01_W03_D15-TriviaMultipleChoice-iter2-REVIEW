//
//  TriviaBrain.swift
//  TriviaMultipleChoice App
//
//  
//

import Foundation
import AVFoundation

struct TriviaBrain {
    
    
    // MARK: - variables
    private var score: Int = 0
    private var questionNumber: Int = 0
    private var player: AVAudioPlayer?
    
    
    // MARK: -  Questions Array
    let questions = [
        TriviaMultipleQuestion(question: "Which is the world's tallest peak?",
                               answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"],
                               correctAnswer:"Everest"),
        
        TriviaMultipleQuestion(question: "Rigoletto opera was composed by?",
                               answers:["Giacomo Puccini", "Wolfgang Amadeus Mozart","Giuseppe Verdi", "Richard Wagner"],
                               correctAnswer:"Giuseppe Verdi"),
        
        TriviaMultipleQuestion(question: "Which is the Capital of Australia?",
                               answers: ["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"],
                               correctAnswer: "Canberra"),
        
        TriviaMultipleQuestion(question: "Turandot opera was composed by?",
                               answers: ["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"],
                               correctAnswer: "Giacomo Puccini"),
        
        TriviaMultipleQuestion(question: "The magic flute opera was composed by?",
                               answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"],
                               correctAnswer: "Wolfgang Amadeus Mozart"),
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




