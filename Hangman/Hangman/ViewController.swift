
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var console: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let player = Player()
    
        let newGame = Hangman(console: self.console)
        
        player.play(newGame)
        
    }


}

