
import Foundation

var clue = """
b | a | k | e | r | i | e | s
b | a | l | l | s | i | e | r
b | a | r | f | l | i | e | s
b | a | r | o | n | i | e | s
b | a | s | i | f | i | e | r
c | a | l | o | r | i | e | s
c | a | n | a | r | i | e | s
c | a | n | o | p | i | e | d
c | a | n | o | p | i | e | s
C | a | s | t | r | i | e | s
c | a | t | b | r | i | e | r
c | a | t | c | h | i | e | r
c | a | v | a | l | i | e | r
c | a | v | i | t | i | e | d
c | a | v | i | t | i | e | s
d | a | i | n | t | i | e | r
d | a | i | n | t | i | e | s
d | a | r | k | l | i | e | r
e | a | r | t | h | i | e | r
e | a | t | e | r | i | e | s
f | a | d |   | d | i | e | t
f | a | m | i | l | i | e | s
f | a | u | l | t | i | e | r
g | a | d | f | l | i | e | s
(vertical ellipsis) |   |   |   |   |   |   |
    (72 words)
"""


let components = clue.components(separatedBy: "|").flatMap({ (rawLetter: String) -> String? in
    
    let letter = rawLetter.trimmingCharacters(in: .whitespacesAndNewlines)
    
    return  letter.count == 1 ? letter : nil

})

let unique = Array(Set(components))

