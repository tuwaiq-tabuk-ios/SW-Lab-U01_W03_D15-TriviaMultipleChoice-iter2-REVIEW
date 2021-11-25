
import Foundation
import AVFoundation
import AVFAudio

struct TriviaBrain {
  
  
  private var currentQuestionIndex = 0
   private var score = 0
  private var rightQuestion = 0
  private var wrongQuestion = 0
   
    
    
  private let question = [
  MutipleChoiceQuestion(question: "What the Capital of Saudi Arabia?",
             answer: ["Tabuk","Jeddah","Riyadha","Abha"],
            correctAnswer: "Riyadha"),


    MutipleChoiceQuestion(question: "What the Capital of Kuwait?",
             answer: ["Tabuk","kuwait","Riyadha","Abha"],
             correctAnswer: "kuwait"),


    MutipleChoiceQuestion(question: "What the Capital of Jordan?",
             answer: ["Amman","kuwait","Riyadha","Abha"],
             correctAnswer: "Amman"),

    MutipleChoiceQuestion(question: "What the Capital of Bahrain?",
             answer:["Amman","kuwait","Bahrain","Abha"],
             correctAnswer: "Bahrain"),


    MutipleChoiceQuestion(question: "What the Capital of Egept?",
             answer: ["Tabuk","kuwait","Riyadha","Qairo"],
             correctAnswer: "Qairo"),]



  
  
  mutating func checkAnswer(_ userAnswer:String) -> Bool {
      print(userAnswer)
      print(question[currentQuestionIndex].answer)
      if userAnswer == question[currentQuestionIndex].correctAnswer{
          score += 5
       rightQuestion += 1
          return true
      }
    score -= 10
  wrongQuestion += 1
    
      return false
  }
    
  
  func checkQuestion() -> String {
      return question[currentQuestionIndex].question
  }

  
    
  func getAnswer() -> [String] {
      return question[currentQuestionIndex].answer
  }
  
  
    
  func checkProgress() -> Float {
      return Float(currentQuestionIndex) / Float(question.count);
  }
  
  
    
  func getScore() -> Int {
      return score
  }
  
    
  func getRightQuestions()-> Int{
    return rightQuestion
  }
    
    
  func getWrongQuestions()-> Int{
    return wrongQuestion
  }

  

  
  
  mutating func nextQuestion() -> Bool {

      if(currentQuestionIndex + 1 < question.count){
        currentQuestionIndex += 1
          return true
      }
      else{
        return false
      }
  }

    
  mutating func startGame() {
    currentQuestionIndex = 0
    score = 0
    wrongQuestion = 0
    rightQuestion = 0
  }
    
    
    func hasUserGoodScore() -> Bool{
        if getRightQuestions()  > getWrongQuestions(){
            print("\(getRightQuestions())")
            print(getWrongQuestions())
            return true
        }
        return false
    }
    
    func playSound() {
        var player: AVAudioPlayer?
        
        guard let url = Bundle.main.url(forResource: "clapping",
                                        withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}



