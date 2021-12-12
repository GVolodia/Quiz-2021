//
//  ResultsViewController.swift
//  Quiz 2021
//
//  Created by noone on 12/6/21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let answers: [Answer]
    
    init?(coder: NSCoder, _ answers: [Answer]) {
        self.answers = answers
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Calculating the most frequent answer type
    func calculateResult() {
        let frequencyOfAnswers = answers.reduce(into: [:]) { counts, answer in
            counts[answer.type, default: 0] += 1
        }
        let frequencyOfAnswersSorted = frequencyOfAnswers.sorted { pair1, pair2 in
            pair1.value > pair2.value
        }
        let mostCommonAnswer = frequencyOfAnswersSorted.first!.key
        updateUI(mostCommonAnswer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateResult()
        navigationItem.hidesBackButton = true
        
    }
    
    func updateUI(_ placeToGo: PlaceToGo) {
        placeLabel.text = placeToGo.definition
        placeLabel.textColor = .red
        
        // Setting image as subview
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: placeToGo.rawValue)
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = .flexibleWidth
        view.insertSubview(imageView, at: 0)
    }
    
    
}
