//
//  ViewController.swift
//  MovieQuiz
//
//  Created by César Alves de Azevedo on 03/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viSoundBar: UIView!
    @IBOutlet var btOption: [UIButton]!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet weak var ivQuiz: UIImageView!
    
    var quizManager: QuizManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quizManager = QuizManager()
        generateQuiz()
    }
    
    func generateQuiz(){
        let round = quizManager.generateRandomQuiz()
        for (index, option) in round.options.enumerated() {
            btOption[index].setTitle(option.name, for: .normal)
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let answer = sender.currentTitle!
        quizManager.checkAnswer(answer)
        generateQuiz()
    }
    
    @IBAction func changeMusicTime(_ sender: UISlider) {
    }
    
    @IBAction func showHideSoundBar(_ sender: UIButton) {
        viSoundBar.isHidden = !viSoundBar.isHidden
    }
    
    @IBAction func playPauseMusic(_ sender: UIButton) {
        
    }
    
}

