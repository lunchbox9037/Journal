//
//  EntryController.swift
//  Journal
//
//  Created by stanley phillips on 1/11/21.
//

import Foundation

class EntryController {
    // MARK: - Properties
    //no longer need shared instance or S.O.T here
    
    // MARK: - CRUD Methods
    //adds a new entry to the entries array for the selected journal
    //make this function global by adding the static keyword
    static func createEntryWith(title: String, body: String, selectedJournal: Journal) {
        //calls the addEntryTo function from the journal controller to add a new entry
        JournalController.shared.addEntryTo(journal: selectedJournal, newEntry: Entry(title: title, body: body))
        //save when adding entry
        //the addEntryTo function will save the data now
    }
    
    //update an entry
    static func update(entry: Entry, withTitle: String, body: String) {
        entry.title = withTitle
        entry.body = body
        //save new entry
        JournalController.shared.saveToPersistentStorage()
    }
    
    //deletes the entry the user swiped in the selected journal
    //make this function global by adding the static keyword
    static func delete(thisEntry: Entry, fromJournal: Journal) {
        //get the index of the entry to be deleted from the array of entries in the selected journal
        JournalController.shared.removeEntryFrom(journal: fromJournal, entry: thisEntry)
        //removeEntryFrom will save data
    }
}
