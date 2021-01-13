//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by stanley phillips on 1/11/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    // MARK: - Properties
    var entry: Entry?
    var journal: Journal?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        clearButton.layer.cornerRadius = 8
        bodyTextView.layer.borderWidth = 0.5
        bodyTextView.layer.borderColor = UIColor.systemFill.cgColor
        bodyTextView.layer.cornerRadius = 8
        updateView()
    }
    
    // MARK: - Actions
    @IBAction func clearEntryPressed(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty,
              let journal = journal else {return}
        
        if let entryToUpdate = entry {
            EntryController.update(entry: entryToUpdate, withTitle: title, body: body)
        } else {
            EntryController.createEntryWith(title: title, body: body, selectedJournal: journal)
        }
    
        //returns back to the tableview controller
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
    
    func updateView() {
        guard let entryDetails = entry else {return}
        titleTextField.text = entryDetails.title
        bodyTextView.text = entryDetails.body
    }
}
