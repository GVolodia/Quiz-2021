//
//  QuestionViewController.swift
//  Quiz 2021
//
//  Created by noone on 12/6/21.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    var questionIndex = 0
    var answerChosen = [Answer]() {
        didSet {
            print(#line, #function, answerChosen)
        }
    }
    var currentAnswers: [Answer] {
        currentQuestion.answers
    }
    
    var currentQuestion: Question {
        Question.all[questionIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        func updateSingleStack() {
            singleStackView.isHidden = false
            for (index, button) in singleButtons.enumerated() {
                button.setTitle(nil, for: [])
                button.tag = index
            }
            for (button, answer) in zip(singleButtons, currentAnswers) {
                button.setTitle(answer.text, for: [])
            }
        }
        
        func updateMultipleStack() {
            multipleStackView.isHidden = false
            for label in multiLabels {
                label.text = nil
            }
            for (label, answer) in zip(multiLabels, currentAnswers) {
                label.text = answer.text
            }
        }
        
        func updateRangedStack() {
            rangedStackView.isHidden = false
            rangedLabels.first?.text = currentAnswers.first?.text
            rangedLabels.last?.text = currentAnswers.last?.text
        }
        
        let totalProgress = Float(questionIndex) / Float(Question.all.count)
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack()
        case .multiple:
            updateMultipleStack()
        case .range:
            updateRangedStack()
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let VC = segue.destination as! ResultsViewController
//        VC.answers = answerChosen
//    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < Question.all.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results Segue", sender: nil)
        }
    }
    
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
    @IBSegueAction func resultsSegue(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, answerChosen)
    }
}
