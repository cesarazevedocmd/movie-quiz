//
//  GameOverViewController.swift
//  MovieQuiz
//
//  Created by César Alves de Azevedo on 03/12/20.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var lbCorrectAnswers: UILabel!
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbCorrectAnswers.text = "\(score)"
    }
    
    @IBAction func btPlayAgain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
