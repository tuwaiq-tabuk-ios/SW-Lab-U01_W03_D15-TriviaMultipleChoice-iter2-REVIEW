//
//  ViewController.swift
//  TriviaMultipleChoice-“Hajer_Mohamed”
//
//  Created by hajer . on 08/04/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Custom properties
    
    var timer: Timer!
    var triviaBrain = TriviaBrain()
    
    
    
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var scorevalueLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var optionFirstButton: UIButton!
    @IBOutlet weak var optionSecondButton: UIButton!
    @IBOutlet weak var optionThirdButton: UIButton!
    @IBOutlet weak var optionFourthButton: UIButton!
    
    @IBOutlet weak var ProgressView: UIProgressView!
    
    
    //   MARK: - view controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButons()
        startGame()
    }
    
    
    //    MARK: - UI configureButons
    
    private func configureButons() {
        configureButton(button: optionFirstButton)
        configureButton(button: optionSecondButton)
        configureButton(button: optionThirdButton)
        configureButton(button: optionFourthButton)
    }
    
    private func configureButton(button : UIButton) {
        button.layer.borderWidth = 3
        button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.layer.cornerRadius = 30
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
    }
    
    
    func clearButtonBackground()  {
        optionFirstButton.backgroundColor = .clear
        optionSecondButton.backgroundColor = .clear
        optionThirdButton.backgroundColor = .clear
        optionFourthButton.backgroundColor = .clear
    }
    
    
    func updateProgressView (){
        ProgressView.progress = triviaBrain.getProgress()
    }
    
    
    @objc func updateScreen(){
        
        questionLabel.text = triviaBrain.getQuestion()
        scorevalueLabel.text = "\(triviaBrain.getScore())"
        
        let possibleAnswers = triviaBrain.getChoices()
        
        optionFirstButton.setTitle(possibleAnswers[0], for: .normal);
        optionSecondButton.setTitle(possibleAnswers[1],for: .normal)
        optionThirdButton.setTitle(possibleAnswers[2], for: .normal)
        optionFourthButton.setTitle(possibleAnswers[3],for: .normal)
        
        clearButtonBackground()
    }
    
    //    MARK: - @IBAction
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let userAnswer = sender.currentTitle else {
            return
        }
        
        let userRightAnswer = triviaBrain.checkAnswer(userAnswer)
        
        if userRightAnswer {
            sender.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        } else {
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(updateScreen),
                             userInfo: nil,
                             repeats: false)
        
        
        updateProgressView()
        
 // MARK: - showAlert
        
        
        if triviaBrain.nextQuestion() {
            print("The Next Question is:\(triviaBrain.getQuestion())")
            
        } else {
            if triviaBrain.hasUserGoodScore() {
                showAlertMessage(myTitle: " Good Job 🎉 ")
                triviaBrain.playSound()
            } else {
                showAlertMessage(myTitle: "GAME OVER")
            }}}

    
    func showAlertMessage(myTitle: String) {
        
        let alert = UIAlertController(title: myTitle,
                                      message: "PLAY AGAIN?",
                                      preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .cancel,
                                      handler: { action in
                                      print("Yes clicked")
                                      self.startGame() }))
        
        
        alert.addAction(UIAlertAction(title: "No",
                                      style: .default,
                                      handler: { action in exit(0)} ))
                                      present(alert,
                                      animated: true,
                                      completion: nil) }
    
    func startGame() {
        triviaBrain.startGame()
        triviaBrain.stopSound()
        updateScreen()
        ProgressView.progress = 0.0
        
    }
}
