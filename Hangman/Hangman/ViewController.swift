//
//  ViewController.swift
//  Hangman
//
//  Created by Saoirse on 18/04/2018.
//  Copyright © 2018 YorkDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player = Player()
        var newGame = Hangman(player)
        
        newGame.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

