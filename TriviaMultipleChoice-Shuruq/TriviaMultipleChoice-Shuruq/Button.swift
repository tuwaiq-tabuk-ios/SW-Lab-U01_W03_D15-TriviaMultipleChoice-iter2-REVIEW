//
//  Button.swift
//  TriviaMultipleChoice-Shuruq
//
//  Created by Shorouq AlAnzi on 19/04/1443 AH.
//

import Foundation
import UIKit

extension UIButton {
  
  func answerButtonPressed () {
    
    let spring = CASpringAnimation(keyPath: "Transform.scale")
    spring.duration = 5
    spring.fromValue = 0.95
    spring.toValue = 1.0
    
    spring.autoreverses = true
    spring.repeatCount = 2
    spring.initialVelocity = 0.5
    spring.damping = 1.0
    
    layer.add(spring, forKey: nil)
  }
}
