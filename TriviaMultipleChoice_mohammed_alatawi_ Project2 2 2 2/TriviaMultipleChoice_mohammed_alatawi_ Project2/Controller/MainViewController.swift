//
//  MainViewController.swift
//  TriviaMultipleChoice_mohammed_alatawi_ Project2
//
//  Created by محمد العطوي on 11/04/1443 AH.
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate {

  @IBOutlet weak var userName: UITextField!

  var username = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
      userName.delegate = self

        // Do any additional setup after loading the view.
    }
    
  func textFieldDidEndEditing(_ textField: UITextField) {
    username = textField.text!
  }
  
  @IBAction func dismissKyboard(_ sender: Any) {
    userName.resignFirstResponder()
    userName.endEditing(true)
  }
  
  
  @IBAction func loginGame(_ sender: Any) {
    userName.resignFirstResponder()
    userName.endEditing(true)
    performSegue(withIdentifier: "show_quiz", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let viewController = segue.destination as? ViewController {
      viewController.username = username
    }
  }

}
