

import Foundation

var text = "Hello, playground"
// _+A+_+S+_+I+E+S
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



func createRegexFor(progress: [String?], exluding : [String]) -> String{
    
    var exludeGroup = ""
    if(exluding.count > 0){
        exludeGroup = "[^" + exluding.joined(separator: "") + "]"
    }
    
    return progress.map{ ($0 == nil ? exludeGroup : $0)! }.joined(separator: "")
}

let regex = createRegexFor(progress:["h","e", nil, nil, "o"], exluding: ["c", "d"])
//let matched = matches(for: "he[^aee][^aee]o", in: text)
