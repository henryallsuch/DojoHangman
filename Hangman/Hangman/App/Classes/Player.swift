
import Foundation

struct Answer {
    var found : Bool
    var atIndex: String.Index? = nil
}

class Player {
    
    var currentGame : Hangman?
    
    let credentials = ["username": "jazz", "password": "apple"]
    
    var brain : Brain = Brain()
    var wolfram : Wolfram = Wolfram()
    var words : Words = Words()
    
    func play(_ game : Hangman) {
    
        currentGame = game
        currentGame?.loginWithPlayer(self, onSuccess: {
            
            self.currentGame?.play()
           
        })
        
    }
    
    func makeGuessUsingOptimalLetters(){
        
        if let game = self.currentGame {
            
        let letterToGuess = self.brain.nextOptimalGuess(forCount: game.wordLength, exluding: game.misses )
        
        print("Guessing: " + letterToGuess)
        
        if(letterToGuess != ""){
            
            game.makeAGuess(letterToGuess)
            
        } else {
            
            print("run out of optimal letters")
            
        }
            
        }
        
    }

    
    func makeGuessUsingWolfram(){
        
         if let game = self.currentGame {
            
        self.wolfram.dictionaryLookup(input: game.progress, onSuccess: { letters in
            
            if(letters.count > 0){
                
                let randomIndex = Int(arc4random_uniform(UInt32(letters.count)))
                let randomLetter = letters[randomIndex]
               
                game.makeAGuess(randomLetter)
                
            } else {
                
                print("wolfram doesn't know! trying regex")
                
               let regex = self.words.createRegexFor(progress: game.progress, exluding: game.misses)
                
                let matches = self.words.searchDictionaryUsingRegex(regex)
                
                if (matches.count > 0){
                    
                    let nextLetterToGuess = self.words.uniqueLettersFromWords(matches, excludingLetters: game.progress);
                    
                } else {
                    
                    //give up
                    
                }
                print(matches)
            
            }
            
            
        })
            
        }
        
    }
    
    func parseGameState(_ gameState : GameState){
        
        if(gameState.won == false && gameState.complete == false){
            
            if let game = currentGame {
                
                game.wordLength = gameState.progress.count
                game.misses = gameState.lettersGuessed
                game.progress = gameState.progress
            
            game.lettersLeftToGuess = gameState.progress.reduce(0) { $0 + ($1 == nil ? 1 : 0) }
            
            if((game.wordLength - game.lettersLeftToGuess < 3)) {
                
                self.makeGuessUsingOptimalLetters()
                
            } else {

                self.makeGuessUsingWolfram()
                
            }
                
        }
            
        } else if(gameState.won == false && gameState.complete == true){
            
             print("game over")
            
        } else if(gameState.won == true){
            
            print("won!")
            
        }
        
    }

}
