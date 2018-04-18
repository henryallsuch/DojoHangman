
import Foundation

struct LoginResponse: Codable {
    var token: String
}

typealias ClosureType = (_ responseData:Any?) throws -> Void

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
                        
                    self.token = loginResponse.token
                
                    print(loginResponse.token)

                    
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
