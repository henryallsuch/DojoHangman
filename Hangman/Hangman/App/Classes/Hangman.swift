
import Foundation
import UIKit

class Hangman {
    
    typealias ClosureWithParams = (_ responseData:Any?) throws -> Void
    typealias ClosureWithNoParams = () throws -> Void
    
    let api = Api()
    
    var misses:[Character] = []
    var hits = [Int: String]()
    let console : ViewController
    
    public var wordLength : Int = 0
    
    init(console : ViewController) {
        
        self.console = console
        self.console.logToView("Init", clearAllText:true);
        
    }
    
    func loginWithPlayer(_ player: Player, onSuccess successCallback : @escaping ClosureWithNoParams) {

        if(api.token == ""){
            
            self.console.logToView("Attempting login..");
            
            api.login(player.credentials, onSuccess: {_ in
                
                self.console.logToView("Success!");
                do {
                    try successCallback()
                }
                catch {

                    print(error)

                }
            })
            
        } else {
       
           self.console.logToView("Already have token");
            do { try successCallback() }
            catch {
              
                print(error)
                
            }
        }

        
    }
    
    func play(){
        
        api.currentGame(onSuccess: {
            (gameState : Any?) in
        
            self.parseGameState(gameState)
            
        })
        
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
    
    func parseGameState(_ gameState : Any?){
        
        let currentGame = gameState as! GameState
        
        if(currentGame.complete == true){
            
            self.console.logToView("Unable to make new game")
            
        } else {
            
            print(currentGame.lettersGuessed)
            print(currentGame.progress)
            
            
        }
        
        self.console.logGameState(currentGame)
        
    }
    
    func newGame (){
        
        api.newGame(onSuccess: {
            (gameState : Any?) in
            
            self.parseGameState(gameState)
            
            
        })
        
    }
    
    
    func makeAGuess(_ Letter : Character) -> Answer {
        
        
        api.makeAGuess(String(Letter), onSuccess: {
            (responseData:Any?) in
            
            
            print(responseData!)
            if let currentGame = String(data: responseData as! Data, encoding: String.Encoding.utf8) {
                self.console.logToView(currentGame)
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
    
    
}
