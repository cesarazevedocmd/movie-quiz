//
//  GameOverViewController.swift
//  MovieQuiz
//
//  Created by César Alves de Azevedo on 03/12/20.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var lbCorrectAnswers: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btPlayAgain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
