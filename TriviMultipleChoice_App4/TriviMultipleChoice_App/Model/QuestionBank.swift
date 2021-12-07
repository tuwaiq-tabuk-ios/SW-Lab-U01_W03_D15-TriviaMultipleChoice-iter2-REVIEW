//
//  QuestionBank.swift
//  TriviMultipleChoice_App
//
//  Created by Mohammed on 15/03/1443 AH.
//

import Foundation
import AVFoundation

struct QuestionsBrain {
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var letVoiceTalk = AVSpeechSynthesizer()
    
    let historyArray = [
        Question(question: "In which year the present Saudi Arabia was founded?",
                 answers: ["1967", "1935", "1922", "1932"],
                 correctAnswer:"1932"),
        Question(question: "Which is the capital of Saudi Arabia?",
                 answers: ["Jeddah","Dammam","Makkah","Riyadh"],
                 correctAnswer:"Riyadh"),
        Question(question: "The King after King Faisal passed away is?",
                 answers: ["King Abdullah", "King Khaled","King Salman", "King Saud"],
                 correctAnswer:"King Khaled"),
        Question(question: "The first king of Saudi Arabia was?",
                 answers: ["King Abdulaziz", "King Faisal","King Fahad","King Abdullah"],
                 correctAnswer: "King Abdulaziz"),
        Question(question: "King Faisal bin Abdulaziz was the....king of Saudi Arabia?",
                 answers:["Third", "Fifth", "First", "Second"],
                 correctAnswer: "Third"),
        Question(question: "What year did Saudi women start driving in Saudi Arabia?",
                 answers:["2011", "2020", "2018", "1999"],
                 correctAnswer: "2018"),
        Question(question: "Total number of countries that shares its border with Saudi Arabia is?",
                 answers:["6", "8", "7", "9"],
                 correctAnswer: "7"),
        Question(question: "In which yaer the national Flag of Saudi Arabia was adopted?",
                 answers:["1932", "1954", "1973", "1980"],
                 correctAnswer: "1973"),
        Question(question: "Which is the official language of Saudi Arabia??",
                 answers:["English", "Arabic", "Persian", "Syriac"],
                 correctAnswer: "Arabic"),
        Question(question: "Which is the currency of Saudi Arabia?",
                 answers:["Riyal", "Dollar", "Pound", "Euro"],
                 correctAnswer: "Riyal")]
    
    
    let sportArray = [
        Question(question: "Most popular sport in Saudi Arabia is?",
                 answers: ["Vollleyball", "Football", "Tennis", "Camel Racing"],
                 correctAnswer:"Football"),
        Question(question: "Saudi Arabia won World Cup in?",
                 answers: ["1990","1982","1998","Never won WC"],
                 correctAnswer:"Never won WC"),
        Question(question: "In which year Saudi Arabia was qualified for the FIFA World Cup for first time?",
                 answers: ["1990", "1994","1998", "2002"],
                 correctAnswer:"1994"),
        Question(question: "How many times Saudi Arabia qualified to World Cup",
                 answers: ["5", "4","8","3"],
                 correctAnswer: "5"),
        Question(question: "What is the Biggest stadioum in Saudi Arabia?",
                 answers:["AlGohra", "Mrsool Park", "Prince Sultan", "King Fahad IS"],
                 correctAnswer: "King Fahad IS"),
        Question(question: "In...Formula One auto racing were in Saudi Arabia for the first time in history",
                 answers:["2021", "2019", "2011", "2015"],
                 correctAnswer: "2021"),
        Question(question: "What is the first Saudi clup founded?",
                 answers:["HilalFC", "NassrFC", "Ittihad FC", "Ahli SC"],
                 correctAnswer: "IttihadFC"),]
    
    
    let artArray = [
        Question(question: "In what year did Saudi Arabia open cinemas in the country?",
                 answers: ["2019", "2009", "1997", "2018"],
                 correctAnswer:"2018"),
        Question(question: "In what year was the first Saudi play presented?",
                 answers: ["1928","1930","1978","1922"],
                 correctAnswer:"1928"),
        Question(question: "Which one of these is Saudi singer?",
                 answers: ["Umm Kulthum", "Talal Maddah","Abdel Halim Hafez", "Fairuz"],
                 correctAnswer:"Talal Maddah"),
        Question(question: "Who is the first Saudi singer?",
                 answers: ["Talal Maddah", "Mohammed Abdu","Abadi","Ibtisam Lutfi"],
                 correctAnswer: "Talal Maddah"),
        Question(question: "Famous art in Saudi culture",
                 answers:["Calligraphy", "Cinema", "Ballet", "Oboe"],
                 correctAnswer: "Calligraphy")]
    
    
    let scienceArray = [
        
        Question(question: "First university in Saudi Arabia is?",
                 answers: ["King Saud University", "Tabuk University", "Imam University", "Not of the above"],
                 correctAnswer:"King Saud University"),
        Question(question: "A sea located in the west of Saudi Arabia?",
                 answers: ["Arabia Sea","Red Sea","Dead Sea","Caribbean Sea"],
                 correctAnswer:"Red Sea"),
        Question(question: "The world's largest producer of desalinated water is?",
                 answers: ["Jordan", "Saudi Arabia","Egybt", "USA"],
                 correctAnswer:"Saudi Arabia"),
        Question(question: "The world's largest producer of cotton is?",
                 answers: ["Saudi Arabia", "India","Egybt","Pakistan"],
                 correctAnswer: "India"),
        Question(question: "The best arabian university is?",
                 answers:["AU Beirut", "Cairo University", "UAE Universirt", "King Abdullaziz University"],
                 correctAnswer: "King Abdullaziz University")]
    
    var quiz = [Question]()
    
    private var questionNumber = 0
    var score = 0
    
    
    mutating func checkTheAnswer(_ userAnswer:String) -> Bool {
        print("~~ \(userAnswer)")
        print(historyArray[questionNumber].correctAnswer)
        if userAnswer == quiz[questionNumber].correctAnswer{
            score += 5
            return true
        }
        
        score -= 10
        return false
    }
    
    func checkQuestion() -> String {
        speechRecognation(quiz[questionNumber].question)
        return quiz[questionNumber].question
    }
    
    
    func checkAnswers() -> [String] {
        return quiz[questionNumber].answers
    }
    
    
    func checkProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count);
    }
    
    
    func checkScore() -> Int {
        return score
    }
    
    
    mutating func nextQuestion() -> Bool {
        //questionNumber += 1
        if (questionNumber + 1 < quiz.count){
            questionNumber += 1
            //  questionNumber = 0
            //   score = 0
            return true
        }
        else{
            return false
        }
    }
    
    
    func getScore()-> Int {
        return score
    }
    
    
    mutating func start() {
        questionNumber = 0
        score = 0
    }
    
    
    func totalQuestion () -> Int {
        return quiz.count
    }
    
    
    mutating func playSound(name:String) {
        if  let pathSound = Bundle.main.path(forResource:name, ofType: .none){
            let url = URL(fileURLWithPath: pathSound)
            audioPlayer = try! AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        }
    }
    
    
    func stopSound() {
        audioPlayer.stop()
    }
    
    
    mutating func reStart() {
        start()
        stopSound()
    }
    
    
    
    
    mutating func hasUserGoodScore(){
        let resultOfQuestions = (Float((5 * totalQuestion())) * 0.7)
        score > Int(resultOfQuestions) ? playSound(name: "clap.wav"): playSound(name: "fail.wav")
    }
    
    
    
    
    func speechRecognation(_ string: String) {
        
        let readable = AVSpeechUtterance(string: string)
        readable.voice = AVSpeechSynthesisVoice(language: "en-GB")
        readable.pitchMultiplier = 1
        if letVoiceTalk.isSpeaking {
            letVoiceTalk.stopSpeaking(at: .immediate)
            letVoiceTalk.speak(readable)
            
        }else{
            letVoiceTalk.speak(readable)
        }
        
    }
    
}

