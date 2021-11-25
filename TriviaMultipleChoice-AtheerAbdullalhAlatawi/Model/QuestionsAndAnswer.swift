//
//  File.swift
//  TriviaMultipleChoice-AtheerAbdullalhAlatawi
//
//  Created by Atheer abdullah on 19/04/1443 AH.
//

import Foundation

class QuestionsAndAnswers {
  let question : String
  let choices : [String]
  let answer : String
  
  init(question:String,
       choices:[String],answer:String) {
    self.question = question
    self.choices = choices
    self.answer = answer
  }
}
