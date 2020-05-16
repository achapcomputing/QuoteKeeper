//
//  DetailViewController.swift
//  QuoteKeeper
//
//  Created by Ashlyn Chapman on 7/22/19.
//  Copyright © 2019 Ashlyn Chapman. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

	@IBOutlet weak var quoteLabel: UILabel!
	@IBOutlet weak var sourceLabel: UILabel!
	@IBOutlet weak var mediumLabel: UILabel!
	@IBOutlet weak var charLabel: UILabel!
	@IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
	@IBAction func deleteButtonTouched(_ sender: Any) {
		let fstore = Firestore.firestore()
		print("delete button touched")
		fstore.collection("quotes").document(selectedDocID).delete() { err in
			if let err = err {
				print("Error removing document: \(err)")
			} else {
				print("Document \(self.selectedDocID) successfully removed!")
			}
		}
		fstore.collection("quotes-info").document("info-\(selectedDocID)").delete() { err in
			if let err = err {
				print("Error removing document: \(err)")
			} else {
				print("Document info-\(self.selectedDocID) successfully removed!")
			}
		}
	}
	
	@IBAction func shareButtonTouched(_ sender: Any) {
		let activityViewController = UIActivityViewController(activityItems: [quoteLabel.text!, "by",  sourceLabel.text ?? ""], applicationActivities: nil)
		present(activityViewController, animated: true, completion: nil)
	}

	var selectedQuote: Quote = Quote()
	var selectedQuoteInfo: QuoteInfo? = QuoteInfo()
	var selectedDocID: String = String()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadQuoteInfoData()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is EditViewController {
			let editVC = segue.destination as? EditViewController
			editVC?.selectedQuote = selectedQuote
			editVC?.selectedQuoteInfo = selectedQuoteInfo
			editVC?.selectedDocID = selectedDocID
		}
	}
	
	func loadQuoteInfoData() {
		selectedDocID = selectedQuote.docID
		var medium = ""
		var char = ""
		var pageNum = ""
        var notes = ""
		let fstore = Firestore.firestore()
		var ref: DocumentReference? = nil
		
		ref = fstore.collection("quotes-info").document("info-\(selectedDocID)")
		ref?.getDocument { (document, err) in
			if let document = document, document.exists {
				medium = document.data()?["medium"] as? String ?? ""
				char = document.data()?["char"] as? String ?? ""
				pageNum = document.data()?["page-num"] as? String ?? ""
                notes = document.data()?["notes"] as? String ?? ""
                self.selectedQuoteInfo = QuoteInfo(medium: medium, char: char, pageNum: pageNum, notes: notes)
				self.setDetailLabels()
			} else {
				print("detailQuotes: Document does not exist")
			}
		}
	}
	
	func setDetailLabels() {
		quoteLabel.text = selectedQuote.quote
		sourceLabel.text = selectedQuote.source
		mediumLabel.text = selectedQuoteInfo?.medium
		charLabel.text = selectedQuoteInfo?.char
		pageLabel.text = selectedQuoteInfo?.pageNum
        notesLabel.text = selectedQuoteInfo?.notes
	}

}
