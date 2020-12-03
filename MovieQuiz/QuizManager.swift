//
//  QuizManager.swift
//  MovieQuiz
//
//  Created by César Alves de Azevedo on 03/12/20.
//

import Foundation

typealias Round = (quiz: Quiz, options: [QuizOption])

class QuizManager {
    var quizes: [Quiz]
    var quizOptions: [QuizOption]
    var round: Round?
    var score: Int
    
    init() {
        score = 0
        do {
            let quizesUrl = Bundle.main.url(forResource: "quizes", withExtension: ".json")!
            let quizOptionsUrl = Bundle.main.url(forResource: "options", withExtension: ".json")!
            
            let quizesData = try Data(contentsOf: quizesUrl)
            let quizOptionsData = try Data(contentsOf: quizOptionsUrl)
            
            quizes = try JSONDecoder().decode([Quiz].self, from: quizesData)
            quizOptions = try JSONDecoder().decode([QuizOption].self, from: quizOptionsData)
        } catch {
            quizes = []
            quizOptions = []
        }
    }
    
    func generateRandomQuiz() -> Round {
        let quizIndex = Int(arc4random_uniform(UInt32(quizes.count)))
        let quiz = quizes[quizIndex]
        var indexes: Set<Int> = [quizIndex]
        
        while indexes.count < 4 {
            let index = Int(arc4random_uniform(UInt32(quizes.count)))
            indexes.insert(index)
        }
        
        let options = indexes.map({quizOptions[$0]})
        
        round = (quiz, options)
        return round!
    }
    
    func checkAnswer(_ answer: String){
        if answer == round?.quiz.name {
            score += 1
        }
    }
}


struct Quiz: Codable {
    let name: String
    let number: Int
}

struct QuizOption: Codable {
    let name: String
}
