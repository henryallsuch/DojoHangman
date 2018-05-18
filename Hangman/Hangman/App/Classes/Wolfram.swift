
import Foundation

struct wolframResponse: Codable {
    var queryresult : wolframResult
}

struct wolframResult: Codable {
    
   var success : Bool
   var pods : [wolframPod]
    
}

struct wolframPod : Codable {
    var title : String
    var scanner : String
    var subpods : [wordPuzzlePod]
}

struct wordPuzzlePod : Codable {
    var plaintext : String
}

typealias ClosureTypeReturningStringArray = (_ responseData:[String]) throws -> Void

class Wolfram {
    
    let appId = "UVRKHA-LL4PJJX7J4"
    let apiUrl = "https://api.wolframalpha.com/v2/query"
    
    
    func dictionaryLookup( input : [String?], onSuccess successCallback : @escaping ClosureTypeReturningStringArray){
        
        var urlComponents = URLComponents(string: apiUrl)
        
        let formated_input = input.map{ ($0 == nil ? "_" : $0)! }.joined(separator: "+")
        
        let queryItems = [URLQueryItem(name:"input", value:formated_input),
                          URLQueryItem(name:"appid", value:appId),
                          URLQueryItem(name:"output", value:"json"),
                          URLQueryItem(name:"scanner", value:"WordPuzzle")]
        
        urlComponents!.queryItems = queryItems
        
        print(urlComponents!.url!)
        
        let request = NSMutableURLRequest(url: urlComponents!.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                
//                if let debugString = String(data: data!, encoding: String.Encoding.utf8) {
//                    print(debugString)
//                }
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let response = try decoder.decode(wolframResponse.self, from: data!)
    
                    let clues = response.queryresult.pods[0].subpods[0].plaintext
                    
                    let letters = self.getUniqueLettersFromWordPuzzle(clue: clues)
                    
                    print(letters)
                    
                    try successCallback(letters)
                  
                
               } catch {
                    print("decoding json failed")
                    print(error)
                
                }
                
            }
        
             task.resume()
        
        }
    
    func getUniqueLettersFromWordPuzzle(clue : String) -> [String] {
        
        let components = clue.components(separatedBy: "|").compactMap({ (rawLetter: String) -> String? in
            
            let letter = rawLetter.trimmingCharacters(in: .whitespacesAndNewlines)
            
            return  letter.count == 1 ? letter : nil
            
        })
        
        return Array(Set(components))
        
    }
    
}
