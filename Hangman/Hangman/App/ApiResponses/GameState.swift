
struct GameState: Codable {
    var lettersGuessed: [String]
    var progress : [String?]
    var misses : Int
    var complete : Bool
    var won : Bool
    var id: String
}


//{"lettersGuessed":["E"],"progress":[null,null,null,null,null,null,"E",null],"misses":0,"complete":false,"won":false,"id":"5ae3a9bd57d74e0014cd56d0"}
