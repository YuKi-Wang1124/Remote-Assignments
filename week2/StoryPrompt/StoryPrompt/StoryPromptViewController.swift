//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by 王昱淇 on 2023/7/5.
//

import UIKit

class StoryPromptViewController: UIViewController {
    
    @IBOutlet weak var storyPromptTextView: UITextView!
    
    var storyPrompt: StoryPromptEntry?
    var isNewStoryPrompt = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyPromptTextView.text = storyPrompt?.description
        
        // isNewStoryPrompt is true, show save and cancel bar button item
        if isNewStoryPrompt {
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStoryPrompt))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelStoryPrompt))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
        }
    }
      
    @objc func cancelStoryPrompt(_ sender: Any) {
        performSegue(withIdentifier: "cancelStoryPrompt", sender: nil)
    }
    
    @objc func saveStoryPrompt(_ sender: Any) {
        NotificationCenter.default.post(name: .StoryPromptSaved, object: storyPrompt)
        performSegue(withIdentifier: "saveStoryPrompt", sender: nil)
    }
}

extension Notification.Name {
    static let StoryPromptSaved = Notification.Name("StoryPromptSave")
}
