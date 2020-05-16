//
//  AllQuotesTableViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/21/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase

class AllQuotesTableViewController: UITableViewController, UITabBarControllerDelegate, UISearchBarDelegate {
	
	var allQuotes = [String : Quote]()
	var allQuotesArray = [Quote]()
	var filteredQuotes = [Quote]()
	
	var detailVC: DetailViewController? = nil
	let searchController = UISearchController(searchResultsController: nil)
    //TODO: add search database button for all quotes VC
    // let searchDBButton = UIButton(type: UIButton.ButtonType)
	
	override func viewDidLoad() {
        super.viewDidLoad()
		loadQuoteData()
		
		searchController.searchBar.delegate = self
		searchController.searchResultsUpdater = self as? UISearchResultsUpdating
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Your Quotes"
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
			self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
		}
		super.viewWillAppear(animated)
	}

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("Tableview setup \(allQuotes.count)")
		if isFiltering() {
			return filteredQuotes.count
		}
        return allQuotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let quote: Quote
		
		if isFiltering() {
			quote = filteredQuotes[indexPath.row]
		} else {
			quote = allQuotesArray[indexPath.row]
		}
		
		cell.textLabel?.text = quote.quote // shows quote in each cell
		cell.detailTextLabel?.text = quote.source // adds source to each cell
		print("cellQuotes: \(allQuotesArray[indexPath.row].quote)")
		return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		if isFiltering() {
			performSegue(withIdentifier: "detailSegue", sender: filteredQuotes[indexPath.row])
		} else {
			performSegue(withIdentifier: "detailSegue", sender: allQuotesArray[indexPath.row])
		}
		print("allToDetailSegueSelectedQuote: \(allQuotesArray[indexPath.row])")
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is DetailViewController {
			let detailVC = segue.destination as? DetailViewController
			detailVC?.selectedQuote = sender as! Quote
			print("selectedQuote: \(detailVC?.selectedQuote)")
		}
	}
	
	func loadQuoteData() {
		var quote = ""
		var source = ""
		var docID = ""
        let currentUserID = Auth.auth().currentUser?.uid
		let fstore = Firestore.firestore()
		fstore.collection("quotes").addSnapshotListener({ (snapshot, error) in
			guard (snapshot?.documents) != nil else {
				print("Error fetching documents: \(error!)")
				return
			}				
			snapshot?.documentChanges.forEach { diff in
				// when loading screen
				if (diff.type == .added) {
					print("New quote: \(diff.document.documentID) => \(diff.document.data())")
					quote = diff.document.data()["quote"] as! String
					source = diff.document.data()["source"] as! String
					docID = diff.document.documentID
                    let newQuote = Quote(quote: quote, source: source, docID: docID, uid: currentUserID!)
					self.allQuotes[docID] = newQuote
					//self.allQuotesArray.append(newQuote)
					// print all quotes in allQuotes array to console
					for (docID, quote) in self.allQuotes {
						print("newQuotes: \(String(describing: self.allQuotes[docID]?.quote)) and \(quote.source ?? "")")
					}
					for element in self.allQuotesArray {
						print("newQuotesArray: \(element.quote) and \(element.source)")
					}
				}
				// from addVC or editVC
				if (diff.type == .modified) {
					print("Modified quote: \(diff.document.documentID) => \(diff.document.data())")
					quote = diff.document.data()["quote"] as! String
					source = diff.document.data()["source"] as! String
					docID = diff.document.documentID
                    let modQuote = Quote(quote: quote, source: source, docID: docID, uid: currentUserID!)
					self.allQuotes[docID] = modQuote
					//self.allQuotesArray.append(modQuote)
					// print all quotes in allQuotes array to console
					for (docID, quote) in self.allQuotes {
						print("modifiedQuotes: \(quote.quote) and \(quote.source)")
					}
				}
				// from allQuotesVC or detailVC
				if (diff.type == .removed) {
					print("Removed quote: \(diff.document.documentID) => \(diff.document.data())")
					docID = diff.document.documentID
					self.allQuotes.removeValue(forKey: docID)
					// print all quotes in allQuotes array to console
					for (docID, quote) in self.allQuotes {
						print("removedQuotes: \(self.allQuotes[docID]?.quote) and \(self.allQuotes[docID]?.source ?? "")")
					}
				}
			}
			// runs every update
			self.allQuotesArray = [] // empties allQuotesArray
			for (ID, _) in self.allQuotes {
                if (self.allQuotes[ID]?.uid == currentUserID) { // if quote was stored by current user
                    self.allQuotesArray.append(self.allQuotes[ID] ?? Quote()) // adds updated quotes to array for cell display
                }
			}
			self.tableView.reloadData()
		})
	}
	
	// for editVC, addVC cancelling back to allQuotesVC
	@IBAction func unwindToAllQuotesVC(_ unwindSegue: UIStoryboardSegue) {
        print("unwinding to all quotes")
    }
    @IBAction func unwindAddtoAllQVC(_ unwindSegue: UIStoryboardSegue) {
        print("unwinding to all quotes")
    }
    

	// MARK: - Search Functions
	func searchBarIsEmpty() -> Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	func filteredContentForSearchText(_ searchText: String, scope: String = "All") {
		// filters candies array based on searchText and stores reults in filteredCandies array
		filteredQuotes = allQuotesArray.filter({( quote : Quote) -> Bool in
			return quote.quote.lowercased().contains(searchText.lowercased()) // only compare lowercased array items and searchText inputs
		})
		tableView.reloadData()
	}
	
	func isFiltering() -> Bool {
		return searchController.isActive && !searchBarIsEmpty()
	}

}

extension AllQuotesTableViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		filteredContentForSearchText(searchController.searchBar.text!)
	}
}
