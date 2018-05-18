
import Foundation

class Words {
    
    var dictionary = ""
    func filterByLength(){
        
    }
    
    func uniqueLettersFromWords(_ words : [String], excludingLetters exluding : [String?] ) -> [String] {
        
        let allLettersFromAllWords = words.joined(separator: "").map { String($0).lowercased() }
        
        let uniqueletters = Set(allLettersFromAllWords)
        
        let exludingSet = Set(exluding.compactMap{ $0?.lowercased() })
        
        return Array(uniqueletters.subtracting(exludingSet))
        
    }
    
    func searchDictionaryUsingRegex(_ regex:String) -> [String] {
        
        if let filepath = Bundle.main.path(forResource: "words", ofType: "txt") {
            do {
                self.dictionary = try String(contentsOfFile: filepath)
                
                return self.matches(for: regex, in: self.dictionary)
                
            } catch {
                print(error)
            }
        } else {
            print("file not found")
        }
        
        return []
    }
    
    func createRegexFor(progress: [String?], exluding : [String]) -> String{
        
        var exludeGroup = ""
        if(exluding.count > 0){
            exludeGroup = "[^" + exluding.joined(separator: "") + "]"
        }
        
        return progress.map{ ($0 == nil ? exludeGroup : $0)! }.joined(separator: "")
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    
}
