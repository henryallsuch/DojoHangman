
import Foundation

class Hangman {
    
    let totalNumberOfGuesses = 3
    var numberOfGuessesLeft = 3
    
//    init() {
//
//        numberOfGuessesLeft = totalNumberOfGuesses
//
//    }
    func makeAGuess(_ Letter : String) -> Bool {
        
        return wordToGuess.contains(Letter)
    
    }
    
    func isGameOver() -> Bool{
        
        if(self.numberOfGuessesLeft == 0){
            
            return true;
            
        } else {
            
            self.numberOfGuessesLeft -= 1
            
            return false
            
        }
    
    }

    
}

class Player {
    
    var misses:[String] = []
    var hits:[String] = []
    
    var wordLength : Int = 0
    
    init(_ length: Int) {
        self.wordLength = length
    }
    
    func generateGuess() -> String {
        
        let firstGuess = "a"
        return firstGuess
    }
    
    func recordTheResult(_ result:Bool, forGuess: String) {
    
    
    }
    
    func recordWordLength(_ length: Int){
        self.wordLength = length
    }
    
    
    
}

let wordToGuess = "cat"
let wordLength = wordToGuess.count

var newGame = Hangman()

let player = Player(wordLength)

while !newGame.isGameOver()  {
    
   let guess = player.generateGuess()
    player.recordTheResult(newGame.makeAGuess(guess), forGuess: guess)
    
}


