//
//  ViewController.swift
//  TriviMultipleChoice_App
//
//  Created by Mohammed on 15/03/1443 AH.
//Mohammed Saqer Aloqbi

import UIKit
class ViewController: UIViewController {
    
    
    //The head labels
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    //Buttons
    @IBOutlet weak var optionFirstButton: UIButton!
    @IBOutlet weak var optionSecondButton: UIButton!
    @IBOutlet weak var optionThirdButton: UIButton!
    @IBOutlet weak var optionFourthButton: UIButton!
    
    //Progress
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //Here we called the question brain from the QuestionBank file
    var questions:QuestionsBrain = QuestionsBrain()
    var arrName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //If you want to change the wallpaper of particular section you can from here 
        if arrName == "History" {
            questions.quiz = questions.historyArray
            backgroundImage.image = UIImage(named: "Wallpaper")
        } else if arrName == "Sport" {
            questions.quiz = questions.sportArray
            backgroundImage.image = UIImage(named: "Wallpaper")
        } else if arrName == "Art" {
            questions.quiz = questions.artArray
            backgroundImage.image = UIImage(named: "Wallpaper")
        } else if arrName == "Science" {
            questions.quiz = questions.scienceArray
            backgroundImage.image = UIImage(named: "Wallpaper")
        }
        
        
        
        //These codes are for the corners desgin of the buttons
        
        //THE FIRST BUUTON
        optionFirstButton.backgroundColor = .white
        optionFirstButton.layer.cornerRadius = 20
        optionFirstButton.layer.borderWidth = 3
        optionFirstButton.layer.borderColor = UIColor.white.cgColor
        
        //THE SECOND BUTTON
        optionSecondButton.backgroundColor = .white
        optionSecondButton.layer.cornerRadius = 20
        optionSecondButton.layer.borderWidth = 3
        optionSecondButton.layer.borderColor = UIColor.white.cgColor
        
        //THE THIRD BUTTON
        optionThirdButton.backgroundColor = .white
        optionThirdButton.layer.cornerRadius = 20
        optionThirdButton.layer.borderWidth = 3
        optionThirdButton.layer.borderColor = UIColor.white.cgColor
        
        //THE FOURTH BUTTON
        optionFourthButton.backgroundColor = .white
        optionFourthButton.layer.cornerRadius = 20
        optionFourthButton.layer.borderWidth = 3
        optionFourthButton.layer.borderColor = UIColor.white.cgColor
        
        updateUI()
        progressBar.progress = 0.0
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let check = questions.checkTheAnswer(userAnswer)
        if check{
            sender.backgroundColor = UIColor.green
        }
        else {
            sender.backgroundColor = UIColor.red
        }
        
        
        if questions.nextQuestion() {
            Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
        else {
            showGameOverMessage()
            questions.hasUserGoodScore()
        }
    }
    
    
    @objc func updateUI(){
        questionLabel.text = questions.checkQuestion()
        progressBar.progress = questions.checkProgress()
        scoreValueLabel.text = "\(questions.checkScore())"
        
        optionFirstButton.backgroundColor = UIColor.white
        optionSecondButton.backgroundColor = UIColor.white
        optionThirdButton.backgroundColor = UIColor.white
        optionFourthButton.backgroundColor = UIColor.white
        
        optionFirstButton.setTitle(questions.checkAnswers()[0], for: .normal);
        optionSecondButton.setTitle(questions.checkAnswers()[1], for: .normal)
        optionThirdButton.setTitle(questions.checkAnswers()[2], for: .normal)
        optionFourthButton.setTitle(questions.checkAnswers()[3], for: .normal)
    }
    
    
    func showGameOverMessage(){
        let ab = UIAlertController(title:"GAME OVER!", message: "You have achieved \(questions.getScore()) Score", preferredStyle: .alert)
        ab.addAction(UIAlertAction(title:"Play again",
                                   style:.default,
                                   handler: { action in
                                    self.questions.reStart()
                                    self.updateUI()
                                   }))
        
        present(ab, animated: true)
        
        
        
    }
    
}





















