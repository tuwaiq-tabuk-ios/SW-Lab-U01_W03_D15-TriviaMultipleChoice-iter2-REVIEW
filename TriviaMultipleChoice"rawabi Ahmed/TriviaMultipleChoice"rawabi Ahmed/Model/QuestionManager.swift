//
//  QuestionManager.swift
//  TriviaMultipleChoice"Dana"
//
//  Created by macbook air on 15/3/1443 AH.
//

import Foundation
import AVFoundation

struct QuizManager {
  
  var player:AVAudioPlayer?
  var playerErrors :AVAudioPlayer?
 private var questionNumber = 0
 private var score = 0
  
  let quiz = [
    Question(question: "A bee flaps its wings at a rate per second?", choices: ["550times", "250times", "350times", "150times"], answer: "350times"),
    Question(question: "The scientist who invented the telephone is? ", choices: ["Alexander Graham Bell", " Joseph Priestley"," Joseph Priestley","Wilhelm Röntfen"], answer: "Alexander Graham Bell"),
    Question(question: "The largest African country in terms of area is the country ?", choices: ["Algeria", "Mauritania","Egypt","Sudan"], answer: "Sudan"),
    Question(question: "Water that freezes faster when put in the freezer is?", choices: ["cold water", "moderate wate","hot water","all at once"], answer: "hot water"),
    Question(question: "The science of studying the activities and functions of the body’s organs is known as?", choices: ["Biological science ", "Physiological science","Ethiopathic science ","Biomedical science"], answer: "Physiological science")]
  
  
  mutating func checkAnswer(_ userAnswer:String) -> Bool {
     
     print(userAnswer)
     print(quiz[questionNumber].answer)
     
     if userAnswer == quiz[questionNumber].answer {
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
     
     return quiz[questionNumber].choices
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

