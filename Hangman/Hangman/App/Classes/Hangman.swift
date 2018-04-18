
import Foundation

class Hangman {
    
    //    var numberOfGuessesLeft : Int = 0
    //    let wordToGuess : String
    
    let api = Api()
    
    var misses:[Character] = []
    var hits = [Int: String]()
    
    public var wordLength : Int = 0
    
    var currentPlayer : Player
    
    init(_ player: Player) {
        
        self.currentPlayer = player
        
        if(api.token == ""){
            
            print("login!")
            
            api.login(player.credentials)
            
        }
    }
    
    func play (){
        
        print("play")
        
        //while !newGame.isGameOver()  {
        //
        //   let guess = player.generateGuess()
        //   player.recordTheResult(newGame.makeAGuess(guess), forGuess: guess)
        //
        //}
    
    }
    
    //api.getCurrentGameOrStartNewOne()
    
    //self.wordToGuess = word
    // self.wordLength = word.count
    //get current game object
    
    //}
    func makeAGuess(_ Letter : Character) -> Answer {
        
        
        api.makeAGuess(String(Letter))
        
        //        if let index = wordToGuess.index(of: Letter) {
        //
        //            return Answer(found:true, atIndex: index)
        //
        //        }
        //
        
        return Answer(found:false, atIndex: nil)
        
    }
    
    //    func isGameOver() -> Bool {
    //
    //        if(self.numberOfGuessesLeft == 0){
    //
    //            return true;
    //
    //        } else {
    //
    //            self.numberOfGuessesLeft -= 1
    //
    //            return false
    //
    //        }
    //
    //    }
    
    
}
