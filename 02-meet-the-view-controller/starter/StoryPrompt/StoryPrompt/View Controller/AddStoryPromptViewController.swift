//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Iyin Raphael on 8/27/21.
//

import UIKit
import PhotosUI

class AddStoryPromptViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nounTextField: UITextField!
    @IBOutlet weak var AdjectiveTextField: UITextField!
    @IBOutlet weak var VerbTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var storyPromptImageView: UIImageView!

    // MARK: - Properties
    let storyPrompt = StoryPromptEntry()

    override func viewDidLoad() {
        super.viewDidLoad()
        numberSlider.value = 7.5
        storyPromptImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(changeImage))
        storyPromptImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: - Methods
    @IBAction func generateStoryPrompt(_ sender: UIButton) {
        updateStoryPrompt()
        if storyPrompt.isValid() {
            performSegue(withIdentifier: "StoryPrompt", sender: nil)
        } else {
            let alert = UIAlertController(title: "Invalid Story Prompt",
                                          message: "Please fill out all of the fields",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { alert in

            }
            alert.addAction(action)
            present(alert, animated: true)
        }
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

    @objc func changeImage() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        present(controller, animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StoryPrompt" {
            guard let storyPromptViewController = segue.destination as? StoryPromptViewController else {
                return
            }
            storyPromptViewController.storyPrompt = storyPrompt
        }
    }
}

    // MARK: - TextField Delegate
extension AddStoryPromptViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateStoryPrompt()
        return true
    }
}

    // MARK: - PHPicker ViewController Delegate
extension AddStoryPromptViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if !results.isEmpty {
            let result = results.first!
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let image = image as? UIImage else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.storyPromptImageView.image = image
                    }
                }
            }
        }
        picker.dismiss(animated: true)
    }
}
