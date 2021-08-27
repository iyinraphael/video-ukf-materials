//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by Iyin Raphael on 8/27/21.
//

import UIKit

class StoryPromptViewController: UIViewController {

    @IBOutlet weak var storyPromptTextField: UITextView!

    var storyPrompt: StoryPromptEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        storyPromptTextField.text = storyPrompt?.description
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
