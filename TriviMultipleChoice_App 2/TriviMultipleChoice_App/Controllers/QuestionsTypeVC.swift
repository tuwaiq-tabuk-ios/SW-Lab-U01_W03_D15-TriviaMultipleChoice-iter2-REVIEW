//
//  QuestionsTypeVC.swift
//  TriviMultipleChoice_App
//
//  Created by Mohammed on 19/04/1443 AH.
//

import UIKit

class QuestionsTypeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toQuestion", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let senderB = sender as? UIButton
        
        if senderB?.tag == 0 {
            if let vc = segue.destination as? ViewController {
                vc.arrName = "History"
            }
        }
        
        else if senderB?.tag == 1 {
            if let vc = segue.destination as? ViewController {
                vc.arrName = "Sport"
            }
        }
        
        else if senderB?.tag == 2 {
            if let vc = segue.destination as? ViewController {
                vc.arrName = "Art"
            }
        }
        
        else if senderB?.tag == 3 {
            if let vc = segue.destination as? ViewController {
                vc.arrName = "Science"
            }
            
        }
    }
    
    
    
    
    
    
    
}

