//
//  StoryPromptTableViewController.swift
//  StoryPrompt
//
//  Created by Iyin Raphael on 8/27/21.
//

import UIKit

class StoryPromptTableViewController: UITableViewController {

    var storyPrompts = [StoryPromptEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyPrompts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPromptCell", for: indexPath)
        cell.textLabel?.text = "Prompt\(indexPath.row + 1)"
        cell.imageView?.image = storyPrompts[indexPath.row].image
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyPrompt = storyPrompts[indexPath.row]
        performSegue(withIdentifier: "ShowStoryPrompt", sender: storyPrompt)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStoryPrompt" {
            guard let storyPromptVC = segue.destination as? StoryPromptViewController,
                  let storyPrompt = sender as? StoryPromptEntry else {
                return
            }
            storyPromptVC.storyPrompt = storyPrompt
        }
    }
    @IBAction func saveStoryPrompt(unwindSegue: UIStoryboardSegue) {
        guard let storyPromptVC = unwindSegue.source as? StoryPromptViewController,
              let storyPrompt = storyPromptVC.storyPrompt else {
            return
        }
        storyPrompts.append(storyPrompt)
        tableView.reloadData()
    }

    @IBAction func cancelStoryPrompt(unwindSegue: UIStoryboardSegue) {
        
    }
}
