//
//  JournalListViewController.swift
//  Journal
//
//  Created by stanley phillips on 1/12/21.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Outlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    @IBOutlet weak var newJournalButton: UIButton!
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newJournalButton.layer.cornerRadius = 8
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        JournalController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        //makre sure there is a title to pass to the createJournalWith function
        guard let title = journalTitleTextField.text, !title.isEmpty else {return}
        JournalController.shared.createJournalWith(title: title)
        //reload the data so the new journal will show in the table view
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    // MARK: - Data Source Methods
    //determines the amount of cells needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    //populates the tableview cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        //create an instance of the journal info for the current row
        let journalInfo = JournalController.shared.journals[indexPath.row]
        cell.textLabel?.text = journalInfo.title
        //check if there are more than 1 entry and print accordingly
        if journalInfo.entries.count > 1 {
            cell.detailTextLabel?.text = "\(journalInfo.entries.count) entries"
        } else {
            cell.detailTextLabel?.text = "\(journalInfo.entries.count) entry"
        }
        

        cell.layer.borderColor = UIColor.systemFill.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8

        return cell
    }
    
    //deletes selected cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            JournalController.shared.delete(thisJournal: JournalController.shared.journals[indexPath.row])
            journalListTableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryList" {
            guard let indexPath = journalListTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryListTableViewController else {return}
            
            let journalToSend = JournalController.shared.journals[indexPath.row]
            destination.journal = journalToSend
        }
    }
}
