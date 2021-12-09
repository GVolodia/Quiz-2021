//
//  ResultsViewController.swift
//  Quiz 2021
//
//  Created by noone on 12/6/21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let answers: [Answer]
    
    init?(coder: NSCoder, _ answers: [Answer]) {
        self.answers = answers
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculatePersonalityResult() {
        let frequancyOfAnswers = answers.reduce(into: [:]) { counts, answer in
            counts[answer.type, default: 0] += 1
        }
        let frequancyOfAnswersSorted = frequancyOfAnswers.sorted { pair1, pair2 in
            pair1.value > pair2.value
        }
        let mostCommonAnswer = frequancyOfAnswersSorted.first!.key
        updateUI(mostCommonAnswer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
    
    func updateUI(_ animal: AnimalType) {
        animalLabel.text = "Вы - это \(animal.rawValue)"
        descriptionLabel.text = animal.definition
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
