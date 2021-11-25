//
//  Extion.swift
//  Prototype-Delegaete-TextField-YousefALbalawi
//
//  Created by Yousef Albalawi on 29/03/1443 AH.
//

import UIKit

extension UIViewController {
  
  func conflgurHldeKayyboardWhenRootVlewTapped () {
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
    
    
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}


