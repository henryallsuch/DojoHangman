
import Foundation

struct WordPuzzleResponse : Codable {
    var plaintext : String
}

struct wolframResponse: Codable {
    
   var success : Bool
   var pods : [WordPuzzleResponse]
    
}
    

class Wolfram {
    
    let appId = "UVRKHA-LL4PJJX7J4"
    let apiUrl = "https://api.wolframalpha.com/v2/query"
    
    func dictionaryLookup( input : String ){
        
    let url = NSURL(string:
        
        apiUrl + "?"
        
        + "appid=" + appId
        
        + "&output=json"
        
        + "&scanner=WordPuzzle"
        
        + "&input=" + input
        
        )
        
        let request = NSMutableURLRequest(url: url as! URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            do {
                
               // wolframResponse
                print(data)
                //try successCallback(data)
                
            } catch {
                print("failed")
                print(error)
                
            }
            
        }
        
         task.resume()
        
    }
    
    
}
