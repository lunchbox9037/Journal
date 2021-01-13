//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by stanley phillips on 1/11/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    // MARK: - Outlets
    
    // MARK: - Properties
    var journal: Journal?

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //reloads data when navigating back to the tableview
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        //unwrap the data for the journal that was passed in
        guard let entry = journal?.entries[indexPath.row] else {return cell}
        //set the title text
        cell.textLabel?.text = entry.title
        //format date from timestamp
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        cell.detailTextLabel?.text = formatter.string(from: entry.timestamp)
        
        //add some additional styling to the cells
        cell.layer.borderColor = UIColor.systemFill.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let entryToDelete = journal?.entries[indexPath.row],
                  let journal = journal else {return}
            JournalController.shared.removeEntryFrom(journal: journal, entry: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEntry" { //this segue is used when the user wants to modify an existing entry
            guard let i = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryDetailViewController else {return}
            //unwraps the journal and entry to be sent to the detail view controller
            guard let entry = journal?.entries[i.row],
                  let journalToPass = journal else {return}
            //send my selected entry with the journal it is from
            destination.entry = entry
            destination.journal = journalToPass
        } else if segue.identifier == "createNewEntry" { //this segue is used when the user wants to add a new entry
            //if the user only wants to create a new entry we dont need to send the entry data
            guard let journalToPass = journal,
                  let destination = segue.destination as? EntryDetailViewController else {return}
            destination.journal = journalToPass
        }
    }
}
