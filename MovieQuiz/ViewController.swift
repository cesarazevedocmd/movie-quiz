//
//  ViewController.swift
//  MovieQuiz
//
//  Created by César Alves de Azevedo on 03/12/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var viSoundBar: UIView!
    @IBOutlet var btOption: [UIButton]!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet weak var ivQuiz: UIImageView!
    @IBOutlet weak var viTimer: UIView!
    @IBOutlet weak var btPlayPause: UIButton!
    
    var quizManager: QuizManager!
    var quizPlayer: AVAudioPlayer!
    var playerItem: AVPlayerItem!
    var backgroundMusicPlayer: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quizManager = QuizManager()
        generateQuiz()
        startTimer()
    }
    
    func startTimer(){
        viTimer.frame = view.frame
        UIView.animate(withDuration: 60.0, delay: 0.0, options: .curveLinear, animations: {
            self.viTimer.frame.size.width = 0
            self.viTimer.frame.origin.x = self.view.center.x
        }, completion: { (success) in
            self.backgroundMusicPlayer.pause()
            self.gameOver()
        })
    }
    
    func gameOver() {
        performSegue(withIdentifier: "gameOverSegue", sender: nil)
        quizPlayer.stop()
    }
    
    func generateQuiz() {
        let round = quizManager.generateRandomQuiz()
        for (index, option) in round.options.enumerated() {
            btOption[index].setTitle(option.name, for: .normal)
        }
        playMusic()
    }
    
    func playBackgroundMusic(){
        let musicUrl = Bundle.main.url(forResource: "MarchaImperial", withExtension: "mp3")!
        slMusic.value = 0
        playerItem = AVPlayerItem(url: musicUrl)
        backgroundMusicPlayer = AVPlayer(playerItem: playerItem)
        backgroundMusicPlayer.volume = 0.1
        backgroundMusicPlayer.play()
        backgroundMusicPlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: nil) { (time) in
            let duration = (time.seconds / self.playerItem.duration.seconds)
            self.slMusic.setValue(Float(duration), animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameOverViewController
        vc.score = quizManager.score
    }
    
    @IBAction func playMusic() {
        
        guard let round = quizManager.round else { return}
        
        ivQuiz.image = UIImage(named: "movieSound")
        
        let quoteMusic = "quote\(round.quiz.number)"
        if let quizMusicUrl = Bundle.main.url(forResource: quoteMusic, withExtension: "mp3") {
            do {
                quizPlayer = try AVAudioPlayer(contentsOf: quizMusicUrl)
                quizPlayer.volume = 1
                quizPlayer.delegate = self
                quizPlayer.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let answer = sender.currentTitle!
        quizManager.checkAnswer(answer)
        generateQuiz()
    }
    
    @IBAction func changeMusicTime(_ sender: UISlider) {
        backgroundMusicPlayer.seek(to: CMTime(seconds: Double(sender.value) * playerItem.duration.seconds, preferredTimescale: 1))
    }
    
    @IBAction func showHideSoundBar(_ sender: UIButton) {
        viSoundBar.isHidden = !viSoundBar.isHidden
    }
    
    @IBAction func playPauseMusic(_ sender: UIButton) {
        if backgroundMusicPlayer.timeControlStatus == .playing {
            backgroundMusicPlayer.pause()
            btPlayPause.setImage(UIImage(named: "play"), for: .normal)
        } else {
            backgroundMusicPlayer.play()
            btPlayPause.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        ivQuiz.image = UIImage(named: "movieSoundPause")
    }
}

