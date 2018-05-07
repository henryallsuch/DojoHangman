
import Foundation

class Brain {
    
    //https://lifehacker.com/5898720/a-better-strategy-for-hangman
    
    let optimalCallingOrder = [
    
        ["A","O","E","I","U","M","B","H"],
        ["A","E","O","I","U","Y","H","B","C","K"],
        ["A","E","O","I","U","Y","S","B","F"],
        ["S","E","A","O","I","U","Y","H"],
        ["E","A","I","O","U","S","Y"],
        ["E","I","A","O","U","S"],
        ["E","I","A","O","U"],
        ["E","I","A","O","U"],
        ["E","I","O","A","U"],
        ["E","I","O","A","D"],
        ["E","I","O","A","F"],
        ["I", "E", "O", "A"],
        ["I", "E", "O"],
        ["I", "E", "A"],
        ["I", "E", "H"],
        ["I", "E", "R"],
        ["I", "E", "A"],
        ["I", "E", "A"],
        ["I", "E"]

    ]
    
    func nextOptimalGuess(forCount: Int, exluding : [String]) -> String {
        
        let optimalLetters = Set(optimalCallingOrder[forCount])
        
        let remainingLetters = optimalLetters.subtracting(Set(exluding))
        
        if remainingLetters.count > 0 {
            return remainingLetters.first!
        } else {
            
            //todo maybe throw here?
            return ""
        }
    
        
    }
    

    
}
