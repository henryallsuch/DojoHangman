
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Answer {
    var found : Bool
    var atIndex: String.Index? = nil
}

class Hangman {
    
    let totalNumberOfGuesses = 3
    var numberOfGuessesLeft : Int
    let wordToGuess : String
    
    public var wordLength : Int = 0
    
    init(_ word : String) {
        
        self.wordToGuess = word
        self.wordLength = word.count
        self.numberOfGuessesLeft = self.totalNumberOfGuesses

    }
    func makeAGuess(_ Letter : Character) -> Answer {
        
        
        let api = Api()
        
        api.makeAGuess(String(Letter))
        
//        if let index = wordToGuess.index(of: Letter) {
//
//            return Answer(found:true, atIndex: index)
//
//        }
//
//        return Answer(found:false, atIndex: nil)
        return Answer(found:false, atIndex: nil)
    
    }
    
    func isGameOver() -> Bool{
        
        if(self.numberOfGuessesLeft == 0){
            
            return true;
            
        } else {
            
            self.numberOfGuessesLeft -= 1
            
            return false
            
        }
    
    }

    
}

class Player {
    
    var misses:[Character] = []
    var hits = [Int: String]()
    
    var currentGame : Hangman
    
    init(_ game: Hangman) {
        self.currentGame = game
    }
    
    func generateGuess() -> Character {
        
        let firstGuess:Character = "a"
        return firstGuess
    }
    
    func recordTheResult(_ result:Answer, forGuess: Character) {
        
        print(result.found)
        
        if(result.found){
            
          // hits.append(forGuess)
            
        } else {
            
            misses.append(forGuess)
        }
    }

}

class Api {
    
    let endpointUrl :String = "https://dojo-hangman-server.herokuapp.com/api/games/current"
    
    var scheme: String = ""
    var baseUrl: String = ""
    
    var token : String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVhY2U1MWRiNWU3OTM4MDAxNDBhMjYwNyIsImlhdCI6MTUyMzQ3MDkzMCwiZXhwIjoxNTIzNTU3MzMwfQ.cxsvZYSkW0nk7qa0kckhj7fgXmCC0ooU1CsjARK09nM"
    
    func login(){
    
    }
    
    func newGame(){
        
    }
    
    func makeAGuess(_ Letter : String){
        
        let parameters = ["letter":Letter] as [String : Any]
        
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let requestBody = postData as Data
            
            makeRequest(method: "PATCH", body: requestBody)
            
        } catch {
           print("failed to parse json")
        }
    
       
        
    }
    
    func makeRequest( method :String, body : Data ){
        
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": token
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: endpointUrl)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
    
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let data = data, let contents = String(data: data, encoding: String.Encoding.utf8) {
                
                print(contents)
                
                //return contents
            }
        }
        task.resume()
        
    }
}

class Words {
    func filterByLength(){
        
    }
    func suggestLetter(){
        
    }
    
}


var newGame = Hangman("cat")
let player = Player(newGame)


//while !newGame.isGameOver()  {
//
//   let guess = player.generateGuess()
//    player.recordTheResult(newGame.makeAGuess(guess), forGuess: guess)
//
//}


