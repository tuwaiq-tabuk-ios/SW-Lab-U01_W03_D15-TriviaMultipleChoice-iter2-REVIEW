//
//  ViewController.swift
//  QuizApp
//
//  Created by Abdulaziz Hussien on 10/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scoreValue: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var buttonA: UIButton!
  @IBOutlet weak var buttonB: UIButton!
  @IBOutlet weak var buttonC: UIButton!
  @IBOutlet weak var buttonD: UIButton!
  @IBOutlet weak var progressBar: UIProgressView!
  
  var questionBrain = QuestionBrain()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    progressBar.progress = 0.0
    updateUI()

  }

  
  @IBAction func answerButton(_ sender: UIButton) {
    let answer = sender.currentTitle!
    if questionBrain.checkAnswer(answer) {
      sender.backgroundColor = .systemGreen
    }else{
      sender.backgroundColor = .systemRed
    }
    
    questionBrain.nextQuestion()
    
    next()
    
  }
  //الوقت المجدول لي الانتقال بين الاسإله
  func next() {
    Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
  }
  //تحديث واجة المستخدم upbateUI
 @objc func updateUI() {
    if questionBrain.numberOfQuestion() < questionBrain.totalQuestionCount() {
      scoreValue.text = "\(questionBrain.scoreOfUser())"
    questionLabel.text = questionBrain.questions()[questionBrain.numberOfQuestion()].question
    
    buttonA.setTitle(questionBrain.questions()[questionBrain.numberOfQuestion()].answers[0], for: .normal)
    buttonB.setTitle(questionBrain.questions()[questionBrain.numberOfQuestion()].answers[1], for: .normal)
    buttonC.setTitle(questionBrain.questions()[questionBrain.numberOfQuestion()].answers[2], for: .normal)
    buttonD.setTitle(questionBrain.questions()[questionBrain.numberOfQuestion()].answers[3], for: .normal)
      
      progressBar.progress = Float(questionBrain.numberOfQuestion() + 1) / Float(questionBrain.totalQuestionCount())
      print(questionBrain.numberOfQuestion())
      print(questionBrain.totalQuestionCount())
      
      buttonA.backgroundColor = .darkGray
        buttonB.backgroundColor = .darkGray
        buttonC.backgroundColor = .darkGray
        buttonD.backgroundColor = .darkGray
      

    } else {
      showAlert()
      questionBrain.userHasScore()
    }
    
  }
  //UIAlertControllerوحدة تحكم تنبيه واجة المستخدم /title لقب
  // func showAlert رسالة او تنبية في نهايت الاسوله / alert تنبيه
  func showAlert() {
    var title = ""
    var message = ""
    
    if questionBrain.userHasScore() {
      title = "Well done"
      message = "I did well"
    } else {
      title = "Game Over"
      message = "Do you want to start over?"
    }
   let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //action عمل
  
    
    let action = UIAlertAction(title: "Yes", style: .default) { alerte in
    self.questionBrain.restart()//اعادت بدء
    self.questionBrain.stopSound()//توقف الصوت
    self.updateUI()//updateUIتحديث واجة المستخدم 🔃

   }
   alert.addAction(action)  //addAction اضف عمل
    
    self.present(alert, animated: true, completion: nil)//انتهاء:لاشي /present عرض او فعل //animated متحرك
   
 }

  
  
}

