
struct GameState: Codable {
    var id: String
    var lettersGuessed: [String]
    var progress : [String?]
    var misses : Int
    var complete : Bool
    var won : Bool
}
