
import UIKit




func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
  return hasConcatenationOnlyDecimalNumbersAndDecimalSeparator(string1:text, string2:string)
    }


func hasConcatenationOnlyDecimalNumbersAndDecimalSeparator(string1: String, string2:String) -> Bool {
  
  
  if hasConcatentionMoreThanOneDecimalSeperator(string1: string1, string2:string2){
    return false
  }
 
  let allowedCharacters = CharacterSet.decimalDigits.union(["."])
  let forbiddenCharacters = allowedCharacters .inverted
  let fundForbiddenCharacters = string2.rangeOfCharacter(from: forbiddenCharacters)
  
  if fundForbiddenCharacters != nil {
      return false
  }else {
      return true
  }
}


func hasConcatentionMoreThanOneDecimalSeperator(string1: String,
                                                 string2: String) -> Bool {
    let string1HasDecimalSeperator = string1.range(of: ".")
    let string2HasDecimalSeperator = string2.range(of: ".")
    
    print("\n \(#function)")
    print("string1HasDecimalSeperator: \(String(describing:string1HasDecimalSeperator))")
    print("string2HasDecimalSeperator: \(String(describing:string2HasDecimalSeperator))")
    
    if string1HasDecimalSeperator != nil,
       string2HasDecimalSeperator != nil {
        return true
    }else {
        return false
    }
}
  

