
import Foundation

struct LoginResponse: Codable {
    var token: String
}

struct GameState: Codable {
    var id: String
    var lettersGuessed: [String]
    var progress : [String?]
    var misses : Int
    var complete : Bool
    var won : Bool
}

typealias ClosureType = (_ responseData:Any?) throws -> Void

class Api {
    
    let apiUrl : String = "https://dojo-hangman-server.herokuapp.com/api/"
    
    var token : String = ""
    
    func login(_ credentials : [String : Any], onSuccess successCallback : @escaping ClosureType){
        
        do {
            
            let postData = try JSONSerialization.data(withJSONObject: credentials, options: [])
            let requestBody = postData as Data
            
            if let guessUrl = NSURL(string: apiUrl + "auth/login" ) {
                
                self.makeRequest(method: "POST", url: guessUrl, body: requestBody, onSuccess: {
                    
                    (responseData: Any?) in
                    
                    let decoder = JSONDecoder()
                    
                    let loginResponse = try decoder.decode(LoginResponse.self, from: responseData as! Data)
                        
                    self.token = loginResponse.token
                    
                    do {
                        
                        try successCallback(loginResponse)
                        
                    } catch {
                        print("failed to call success callback")
                        print(error)
                        
                    }

                    
                })
            }
            
        } catch {
            
            print("failed to parse json 1")
            
        }
        
        
    }
    
    func currentGame(){
       // do {
            
           
            if let guessUrl = NSURL(string: apiUrl + "games/current" ) {
                
                self.makeRequest(method: "GET", url: guessUrl, body: nil, onSuccess: {
                    
                    (responseData: Any?) in
                    
                    if let debugString = String(data: responseData as! Data, encoding: String.Encoding.utf8) {
                        print(debugString)
                    }
                    
                    let decoder = JSONDecoder()
                    
                    let currentGame = try decoder.decode(GameState.self, from: responseData as! Data)
                    
                   print(currentGame)
                    
//                    do {
//
//                        try //successCallback(loginResponse)
//
//                    } catch {
//                        print("failed to call success callback")
//                        print(error)
//
//                    }
                    
                    
                })
            }
            
//        } catch {
//
//            print("failed to parse json 1")
//
//        }
    }
    
    func newGame(){
        
        
        
    }
    
    func makeAGuess(_ Letter : String, onSuccess successCallback : @escaping ClosureType){
        
        let parameters = ["letter":Letter] as [String : Any]
        
        do {
            
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let requestBody = postData as Data
            if let guessUrl = NSURL(string: apiUrl + "game/current" ) {
                
                self.makeRequest(method: "PATCH", url: guessUrl, body: requestBody, onSuccess: {
                    (responseData:Any?) in
                    do {
                        try successCallback(responseData!)
                    } catch {
                        print("callback failed")
                        print(error)
                        
                    }
                    
                })
            }
            
        } catch {
            print("failed to parse json")
        }
        
    }
    
    func makeRequest( method :String, url : NSURL, body : Data?, onSuccess successCallback : @escaping ClosureType ){
        
        let headers = ["Content-Type": "application/json", "x-access-token": token]
        
        let request = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        if(body != nil){
            request.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
                do {
       
                    try successCallback(data)
                    
                } catch {
                    print("failed")
                    print(error)
                    
                }
        
        }
        task.resume()
        
    }
}
