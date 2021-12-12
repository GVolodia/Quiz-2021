//
//  QuestionViewController.swift
//  Quiz 2021
//
//  Created by noone on 12/6/21.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiButton: UIButton!
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedButton: UIButton!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var segmentStackView: UIStackView!
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var segmentButton: UIButton!
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    let pictures = ["еда.jpeg", "природа.jpeg", "экск.jpeg", "море.jpeg"]
    var questionIndex = 0
    var answerChosen = [Answer]()
    var currentAnswers: [Answer] {
        currentQuestion.answers
    }
    
    var currentQuestion: Question {
        Question.all[questionIndex]
    }
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Setting image as subview
    func updateSubview() {
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: pictures[questionIndex])
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = .flexibleWidth
        view.insertSubview(imageView, at: questionIndex)
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        segmentStackView.isHidden = true
        
        updateSubview()
        
        func updateSingleStack() {
            singleStackView.isHidden = false
            
            // Clearing all buttons and setting their tags
            for (index, button) in singleButtons.enumerated() {
                button.setTitle(nil, for: [])
                button.tag = index
            }
            // Putting text in buttons
            for (button, answer) in zip(singleButtons, currentAnswers) {
                button.setTitle(answer.text, for: [])
                button.setTitleColor(.white, for: .normal)
            }
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            
        }
        
        func updateMultipleStack() {
            multipleStackView.isHidden = false
            // Clearing all labels
            for label in multiLabels {
                label.text = nil
            }
            // Putting text in labels
            for (label, answer) in zip(multiLabels, currentAnswers) {
                label.text = answer.text
                label.textColor = .green
            }
            // Setting other elements with the same color
            multiButton.setTitleColor(.green, for: .normal)
            questionLabel.textColor = .green
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.green]
        }
        
        func updateRangedStack() {
            rangedStackView.isHidden = false
            
            // Setting to labels with text and color
            rangedLabels.first?.text = currentAnswers.first?.text
            rangedLabels.first?.textColor = .blue
            rangedLabels.last?.text = currentAnswers.last?.text
            rangedLabels.last?.textColor = .blue
            
            // Setting other elements with the same color
            questionLabel.textColor = .blue
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue]
            rangedButton.setTitleColor(.blue, for: .normal)
        }
        
        func updateSegmentStack() {
            segmentStackView.isHidden = false
            
            // Setting all elements with the same color
            questionLabel.textColor = .black
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            segmentButton.setTitleColor(.black, for: .normal)
            
        }
        
        // Setting progress view
        let totalProgress = Float(questionIndex) / Float(Question.all.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        
        questionLabel.text = currentQuestion.text
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack()
        case .multiple:
            updateMultipleStack()
        case .range:
            updateRangedStack()
        case .segment:
            updateSegmentStack()
        }
        
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < Question.all.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results Segue", sender: nil)
        }
    }
    //MARK: Actions
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let index = sender.tag
        guard 0 <= index && index < currentAnswers.count else {
            return
        }
        let answer = currentAnswers[index]
        answerChosen.append(answer)
        nextQuestion()
    }
    
    @IBAction func multiButtonPressed() {
        for (index, multiSwitch) in multiSwitches.enumerated() {
            if multiSwitch.isOn && index < currentAnswers.count {
                let answer = currentAnswers[index]
                answerChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed() {
        let index = Int(round(rangedSlider.value*(Float(currentAnswers.count)-1)))
        if index < currentAnswers.count {
            let answer = currentAnswers[index]
            answerChosen.append(answer)
        }
        nextQuestion()
    }
    
    @IBAction func segmentButtonPressed(_ sender: UIButton) {
        let index = segments.selectedSegmentIndex
        if index < currentAnswers.count {
            let answer = currentAnswers[index]
            answerChosen.append(answer)
        }
        nextQuestion()
    }
    
    // Performing segue action, initialazing Result View Controller and passing quiz results
    @IBSegueAction func resultsSegue(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, answerChosen)
    }
}
