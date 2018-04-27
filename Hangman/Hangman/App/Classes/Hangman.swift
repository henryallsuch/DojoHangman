
import Foundation
import UIKit

class Hangman {
    
    typealias ClosureWithParams = (_ responseData:Any?) throws -> Void
    typealias ClosureWithNoParams = () throws -> Void
    
    let api = Api()
    
    var misses:[Character] = []
    var hits = [Int: String]()
    let console : UITextView
    
    public var wordLength : Int = 0
    
    init(console : UITextView) {
        
        self.console = console
        logToView("New Game", clearAllText:true);
        
    }
    
    func loginWithPlayer(_ player: Player, onSuccess successCallback : @escaping ClosureWithNoParams) {

        if(api.token == ""){
            
            logToView("Attempting login..");
            
            api.login(player.credentials, onSuccess: {_ in
                
                self.logToView("Success!");
                do {
                    try successCallback()
                }
                catch {

                    print(error)

                }
            })
            
        } else {
       
           logToView("Already have token");
            do { try successCallback() }
            catch {
              
                print(error)
                
            }
        }

        
    }
    
    func play(){
        
        print("play")
        
        api.currentGame()
        
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
        
        
        api.makeAGuess(String(Letter), onSuccess: {
            (responseData:Any?) in
            
            
            print(responseData!)
            if let currentGame = String(data: responseData as! Data, encoding: String.Encoding.utf8) {
                self.logToView(currentGame)
            }
            
        })
        
        //        if let index = wordToGuess.index(of: Letter) {
        //
        //            return Answer(found:true, atIndex: index)
        //
        //        }
        //
        
        return Answer(found:false, atIndex: nil)
        
    }
    
    func logToView(_ message :String, clearAllText: Bool? = nil){
        
        //always update UI in main thread!
        DispatchQueue.main.async {
            
            if clearAllText != nil {
                self.console.text = ""
            }
            self.console.text.append(message);
            self.console.text.append("\n");
            print(message)
            
        }
    }
    
}
