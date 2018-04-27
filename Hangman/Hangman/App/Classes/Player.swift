
import Foundation

struct Answer {
    var found : Bool
    var atIndex: String.Index? = nil
}

class Player {
    
    var currentGame : Hangman?
    
    let credentials = ["username": "jazz", "password": "apple"]
    
    func play(_ game : Hangman) {
    
        currentGame = game
        currentGame?.loginWithPlayer(self, onSuccess: {
            
            print("player logged in")
            
            self.currentGame?.play()
            //self.makeAGuess()
            
        })
        
    }
    
    func makeAGuess(){
        
        if let wasCorrect : Answer = currentGame?.makeAGuess(generateGuess()) {
            
            print(wasCorrect)
        }
        
    }
    
    func generateGuess() -> Character {
        
        let firstGuess:Character = "a"
        return firstGuess
    }
    
    func recordTheResult(_ result:Answer, forGuess: Character) {
        
        //        print(result.found)
        //
        //        if(result.found){
        //
        //          // hits.append(forGuess)
        //
        //        } else {
        //
        //           // misses.append(forGuess)
        //        }
    }
    
}
