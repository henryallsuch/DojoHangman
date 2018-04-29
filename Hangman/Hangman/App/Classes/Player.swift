
import Foundation

struct Answer {
    var found : Bool
    var atIndex: String.Index? = nil
}

class Player {
    
    var currentGame : Hangman?
    
    let credentials = ["username": "jazz", "password": "apple"]
    
    var brain : Brain = Brain()
    
    func play(_ game : Hangman) {
    
        currentGame = game
        currentGame?.loginWithPlayer(self, onSuccess: {
            
            self.currentGame?.play()
           
        })
        
    }
    
    func parseGameState(_ gameState : GameState){
        
        let letterCount = gameState.progress.count
        
        let nilCount = gameState.progress.reduce(0) { $0 + ($1 == nil ? 1 : 0) }
        
        if(nilCount == letterCount){
            
             let letterToGuess = self.brain.optimalGuess(forLetterCount: letterCount)
            
            currentGame?.makeAGuess(letterToGuess)
            
        } else {
            
            print("got a letter!")
            
        }
        
//        if(currentGame.misses == 0 or nilCount = letterCount){
//
//           let letterToGuess = self.brain.optimalGuess(forLetterCount: letterCount)
//
//        } else {
//
//        }
        // self.brain.makeAGuess()
    }
//    
//    func makeAGuess(){
//        
//        currentGame?.makeAGuess(self.brain.generateGuess())
//        
//    }
    
    
}
