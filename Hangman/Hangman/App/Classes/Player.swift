
import Foundation

struct Answer {
    var found : Bool
    var atIndex: String.Index? = nil
}

class Player {
    
    let credentials = ["username": "jazz", "password": "apple"]
    
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
