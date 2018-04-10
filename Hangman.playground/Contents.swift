
import Foundation

class Hangman {
    
    let totalNumberOfGuesses = 3
    var numberOfGuessesLeft : Int
    let wordToGuess : String
    
    public var wordLength : Int = 0
    
    init(_ word : String) {
        
        self.wordToGuess = word
        self.wordLength = word.count
        self.numberOfGuessesLeft = self.totalNumberOfGuesses

    }
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
    var hits = [Int: String]()
    
    var currentGame : Hangman
    
    init(_ game: Hangman) {
        self.currentGame = game
    }
    
    func generateGuess() -> String {
        
        let firstGuess = "a"
        return firstGuess
    }
    
    func recordTheResult(_ result:Bool, forGuess: String) {
        
        print(result)
        
        if(result){
            
           // hits.append(String)
            
        } else {
            
            misses.append(forGuess)
        }
    }

}

var newGame = Hangman("cat")

let player = Player(newGame)

while !newGame.isGameOver()  {
    
   let guess = player.generateGuess()
    player.recordTheResult(newGame.makeAGuess(guess), forGuess: guess)
    
}


