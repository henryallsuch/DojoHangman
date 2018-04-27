
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var console: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let player = Player()
    
        let newGame = Hangman(console: self)
        
        player.play(newGame)
        
    }
    
    func logToView(_ message :String, clearAllText: Bool? = nil , newLine: Bool? = true){
        
        //always update UI in main thread!
        DispatchQueue.main.async {
            
            if clearAllText != nil {
                self.console.text = ""
            }
            self.console.text.append(message);
            if(newLine != nil){
                self.console.text.append("\n");
            }
            print(message)
            
        }
    }
    
    func logGameState(_ currentGame: GameState){
        
        for letterToGuess in currentGame.progress {
            if(letterToGuess == nil){
                logToView(" _ ", clearAllText: nil, newLine: nil)
            } else {
                logToView(letterToGuess!, clearAllText: nil, newLine: nil)
            }
        }
        
        //new line
        logToView("")
        
    }


}

