//
//  JournalController.swift
//  Journal
//
//  Created by stanley phillips on 1/12/21.
//

import Foundation

class JournalController {
    // MARK: - Properties
    //create a shared instance
    static var shared = JournalController()
    
    //create source of truth
    var journals: [Journal] = []
    
    // MARK: - CRUD methods
    //create journal function
    func createJournalWith(title: String) {
        //creates a journal with a title provided by the user
        journals.append(Journal(title: title))
        //save after creating
        saveToPersistentStorage()
    }
    
    func addEntryTo(journal: Journal, newEntry: Entry) {
        journal.entries.append(newEntry)
        //save after adding
        saveToPersistentStorage()
    }
    
    //delete a journal
    func delete(thisJournal: Journal) {
        guard let selectedIndex = journals.firstIndex(of: thisJournal) else {return}
        journals.remove(at: selectedIndex)
        //save after deleting
        saveToPersistentStorage()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let entryToDelete = journal.entries.firstIndex(of: entry) else {return}
        journal.entries.remove(at: entryToDelete)
        //save after removing
        saveToPersistentStorage()
    }
    
    
    // MARK: - Persistence
    //create a url
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    //save data
    func saveToPersistentStorage() {
        do {
            //decode and assign the entries array to the a data variable
            let data = try JSONEncoder().encode(journals)
            //write the data to a the file url that was created
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //load data
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
