//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Iyin Raphael on 8/27/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nounTextField: UITextField!
    @IBOutlet weak var AdjectiveTextField: UITextField!
    @IBOutlet weak var VerbTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberSlider: UISlider!

    // MARK: - Properties
    let storyPrompt = StoryPromptEntry()

    override func viewDidLoad() {
        super.viewDidLoad()
        numberSlider.value = 7.5
        storyPrompt.noun = "toaster"
        storyPrompt.adjective = "smelly"
        storyPrompt.verb = "burps"
        storyPrompt.number = 10
    }
    // MARK: - Methods
    @IBAction func generateStoryPrompt(_ sender: UIButton) {
        updateStoryPrompt()
        print(storyPrompt)
    }
    @IBAction func changeNumber(_ sender: UISlider) {
        numberLabel.text = "Number: \(Int(sender.value))"
        storyPrompt.number = Int(sender.value)
    }
    @IBAction func changeStoryType(_ sender: UISegmentedControl) {
        if let genre = StoryPrompts.Genre(rawValue: sender.selectedSegmentIndex) {
            storyPrompt.genre = genre
        } else {
            storyPrompt.genre = .scifi
        }
    }

    func updateStoryPrompt() {
        storyPrompt.noun = nounTextField.text ?? ""
        storyPrompt.adjective = AdjectiveTextField.text ?? ""
        storyPrompt.verb = VerbTextField.text ?? ""
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateStoryPrompt()
        return true
    }
}
