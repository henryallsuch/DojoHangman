
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
    
    func play(_ game : Hangman) {
    
        currentGame = game
        currentGame?.loginWithPlayer(self, onSuccess: {
            
            self.currentGame?.play()
           
        })
        
    }
    
    func parseGameState(_ gameState : GameState){
        
        if(gameState.won == false && gameState.complete == false){
            
            let letterCount = gameState.progress.count
            
            let nilCount = gameState.progress.reduce(0) { $0 + ($1 == nil ? 1 : 0) }
            
            if((letterCount - nilCount < 3)) {
                
                let letterToGuess = self.brain.nextOptimalGuess(forCount: letterCount, exluding: gameState.lettersGuessed)
                
                print("Guessing: " + letterToGuess)
                
                if(letterToGuess != ""){
                    
                    currentGame?.makeAGuess(letterToGuess)
                    
                } else {
                    
                    print("run out of optimal letters")
                    
                }
            } else {
                // use wolfram
                print("wolfram")
                
                self.wolfram.dictionaryLookup(input: gameState.progress)
                
            }
            
        } else if(gameState.won == false && gameState.complete == true){
            
             print("game over")
            
        } else if(gameState.won == true){
            
            print("won!")
            
        }
        
    }

}
