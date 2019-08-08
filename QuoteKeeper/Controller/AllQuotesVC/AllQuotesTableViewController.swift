//
//  AllQuotesTableViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/21/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase

class AllQuotesTableViewController: UITableViewController {
	
	var allQuotes = [Quote]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		loadQuoteData()
	}

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("Tableview setup \(allQuotes.count)")
        return allQuotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = allQuotes[indexPath.row].quote // shows quote in each cell
		cell.detailTextLabel?.text = allQuotes[indexPath.row].source // adds source to each cell
		print("cellQuotes: \(allQuotes[indexPath.row].quote)")
        return cell
    }
	
	var segueIdentifiers = ["detailSegue", "editSegue"]
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		performSegue(withIdentifier: "detailSegue", sender: allQuotes[indexPath.row])
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is DetailViewController {
			let detailVC = segue.destination as? DetailViewController
			detailVC?.selectedQuote = sender as! Quote
		}
	}
	
	// TODO: RELOAD QUOTES WHEN NEW QUOTE IS ADDED TO DATABASE
	
	func loadQuoteData() {
		var quote = ""
		var source = ""
		var docID = ""
		let fstore = Firestore.firestore()
		var ref: CollectionReference? = nil
		
		ref = fstore.collection("quotes")
		ref?.getDocuments() { (querySnapshot, err) in
			if let err = err {
				print("Error getting documents: \(err)")
			} else {
				for document in querySnapshot!.documents {
					print("\(document.documentID) => \(document.data())")
					quote = document.data()["quote"] as! String
					source = document.data()["source"] as! String
					docID = document.documentID
					var newQuote: Quote
					newQuote = Quote(quote: quote, source: source, docID: docID)
					self.allQuotes.append(newQuote)
				}
				for element in self.allQuotes {
					print("allQuotes: \(element.quote) and \(element.source ?? "") and \(element.docID)")
				}
			}
			self.tableView.reloadData()
		}
	}
	
	

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/*
class UserCell: UITableViewCell {
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
*/
