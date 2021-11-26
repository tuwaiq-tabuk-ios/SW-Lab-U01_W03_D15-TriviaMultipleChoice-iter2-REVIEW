//
//  StartVC.swift
//  TriviaMultipleChoice-Shuruq
//
//  Created by Shorouq AlAnzi on 12/04/1443 AH.
//

import Foundation
import UIKit

class StartVC:UIViewController{
  
  
  var vc = UIViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  
  @IBAction func start_Button(_ sender: UIButton) {
    
    vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")as! ViewController
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
    
    
  }

  
  
}
