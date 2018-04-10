
import Foundation

class Game {
    
    let totalNumberOfGuesses = 6;
    var numberOfGuessesLeft = 6;
    var misses:[String] = []
    
}

let wordToGuess = "cat"
let wordLength = wordToGuess.count

func makeAGuess(_ Letter : String) -> Bool {
    
    return wordToGuess.contains(Letter)
}


let firstGuess = "A"
let firstAnswer: Bool = makeAGuess(firstGuess)


new Game

func generateGuess() -> String {
    
    return firstGuess
}


firstAnswer
