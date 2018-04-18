
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Answer {
    var found : Bool
    var atIndex: String.Index? = nil
}

struct LoginResponse: Codable {
    var token: String
}

typealias ClosureType = (_ responseData:Any?) throws -> Void

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
    
   // init() {
        
        
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

class Api {
    
    let apiUrl : String = "https://dojo-hangman-server.herokuapp.com/api/"
    
    var token : String = ""
    
    func login(_ credentials : [String : Any]){
        
        do {
            
        let postData = try JSONSerialization.data(withJSONObject: credentials, options: [])
        let requestBody = postData as Data
            
        if let guessUrl = NSURL(string: apiUrl + "auth/login" ) {
            
            self.makeRequest(method: "POST", url: guessUrl, body: requestBody, onSuccess: {
                
                (responseData: Any?) in
                
                let decoder = JSONDecoder()
                
              
                let loginResponse = try decoder.decode(LoginResponse.self, from: responseData as! Data)
                    
                print(loginResponse)
            
                //if(loginResponse.token.is){
                 //  print(self.token)
               // }
                
                //check for token & save
                
            })
        }
            
         } catch {
            
            print("failed to parse json 1")
            
        }
        
        
    }
    
    func newGame(){
        
    }
    
    func makeAGuess(_ Letter : String){
        
        let parameters = ["letter":Letter] as [String : Any]
        
        do {
            
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let requestBody = postData as Data
            if let guessUrl = NSURL(string: apiUrl + "game/current" ) {
                
                    self.makeRequest(method: "PATCH", url: guessUrl, body: requestBody, onSuccess: {
                            (responseData:Any?) in
                        //
                       // print(responseData!)
                
                    })
            }
            
        } catch {
           print("failed to parse json")
        }
        
    }
    
    func makeRequest( method :String, url : NSURL, body : Data, onSuccess successCallback : @escaping ClosureType ){
        
        let headers = ["Content-Type": "application/json", "x-access-token": token]
        
        let request = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
    
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let data = data, let jsonString = String(data: data, encoding: String.Encoding.utf8) {
                
              
                   successCallback(jsonString)
                
            
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



let player = Player()
var newGame = Hangman(player)

//while !newGame.isGameOver()  {
//
//   let guess = player.generateGuess()
//   player.recordTheResult(newGame.makeAGuess(guess), forGuess: guess)
//
//}


