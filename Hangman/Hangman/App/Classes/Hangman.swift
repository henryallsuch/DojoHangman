
import Foundation
import UIKit

class Hangman {
    
    typealias ClosureWithParams = (_ responseData:Any?) throws -> Void
    typealias ClosureWithNoParams = () throws -> Void
    
    let api = Api()
    
    public var misses:[String] = []
    public var progress: [String?] = []
    let console : ViewController
    
    var currentPlayer : Player? = nil
    
    public var wordLength : Int = 0
    public var lettersLeftToGuess = 0;
    
    init(console : ViewController) {
        
        self.console = console
        self.console.logToView("Init", clearAllText:true);
        
    }
    
    func loginWithPlayer(_ player: Player, onSuccess successCallback : @escaping ClosureWithNoParams) {

        if(api.token == ""){
            
            currentPlayer = player
            
            api.login(player.credentials, onSuccess: {_ in
                
                
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
        
    
    }
    
    func newGame(){
        
        api.newGame(onSuccess: {
            (gameState : Any?) in
            
            self.parseGameState(gameState)
            
            
        })
        
    }
    
    func makeAGuess(_ Letter : String)  {
        
        self.console.logToView("Guessing : \(Letter)");
        
        api.makeAGuess(String(Letter), onSuccess: {
            (gameState:Any?) in
            
            self.parseGameState(gameState)
            
        })
        
    }
    
    func parseGameState(_ gameState : Any?){
        
        let currentGame = gameState as! GameState
        
        if(currentGame.complete == true){
            
            self.console.logToView("Game Over")
            
        } else {
            
            self.currentPlayer?.parseGameState(currentGame)
            
            self.console.logGameState(currentGame)
            
        }
        
        
    }
    
    
}
